const std = @import("std");
const argsAlloc = std.process.argsAlloc;
const argsFree = std.process.argsFree;
const exit = std.process.exit;
const c_allocator = std.heap.c_allocator;
const print = std.debug.print;

const serialize = @import("base.zig").serialize;

const core = @import("lexbor").core;
const dom = @import("lexbor").dom;
const html = @import("lexbor").html;

fn usage() void {
    print("Usage:\n", .{});
    print("    zig build html-parse -- <file-path-to-html>:\n", .{});
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(c_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const args = try argsAlloc(allocator);
    defer argsFree(allocator, args);

    if (args.len != 2) {
        usage();
        exit(0);
    }

    for (args) |arg| {
        print("{s}\n", .{arg});
    }

    // const input = "<div><p>blah-blah-blah</div>";
    //
    // // Initialization
    // const doc = html.document.create();
    // if (doc == null) return error.FailedToCreate;
    // defer _ = html.document.destroy(doc);
    //
    // // Parse HTML
    // const status = html.document.parse(doc, input, input.len);
    // if (status != core.Status.ok) return error.FailedToParse;
    //
    // // Print Incoming Data
    // print("HTML:\n", .{});
    // print("{s}\n", .{input});
    //
    // // Print Result
    // print("\nHTML Tree:\n", .{});
    // serialize(dom.interface.node(doc));
}
