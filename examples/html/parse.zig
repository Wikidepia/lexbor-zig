const std = @import("std");
const argsAlloc = std.process.argsAlloc;
const argsFree = std.process.argsFree;
const c_allocator = std.heap.c_allocator;
const exit = std.process.exit;
const print = std.debug.print;
const printf = std.c.printf;

const core = @import("lexbor").core;
const html = @import("lexbor").html;

fn failed(with_usage: bool, comptime fmt: []const u8, args: anytype) void {
    print(fmt, args);

    if (with_usage) usage();

    exit(1);
}

fn usage() void {
    print("Usage:\n", .{});
    print("    zig build html-parse -- <file-path-to-html>:\n", .{});
}

pub fn main() !void {
    var len: usize = undefined;
    var em: html.Encoding = undefined;
    var status: core.Status = undefined;

    var arena = std.heap.ArenaAllocator.init(c_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try argsAlloc(allocator);
    defer argsFree(allocator, args);

    if (args.len != 2) {
        usage();
        exit(0);
    }

    const content = core.fs.fileEasyRead(args[1], &len);
    if (content == null) {
        failed(true, "Failed to read file: {s}\n", .{args[1]});
    }

    status = html.encoding.init(&em);
    if (status != core.Status.ok) {
        failed(false, "Failed to init html encoding\n", .{});
    }

    status = html.encoding.determine(&em, content.?, @ptrFromInt((@intFromPtr(content.?.ptr) + len)));
    if (status != core.Status.ok) {
        core.free(content.?.ptr);
        _ = html.encoding.destroy(&em, false);

        failed(false, "Failed to determine encoding\n", .{});
    }

    const entry = html.encoding.metaEntry(&em, 0);
    if (entry != null) {
        _ = printf("%.*s\n", @intFromPtr(entry.?.end) - @intFromPtr(entry.?.name), entry.?.name);
    } else {
        print("Encoding not found\n", .{});
    }

    core.free(content.?.ptr);
    _ = html.encoding.destroy(&em, false);
}
