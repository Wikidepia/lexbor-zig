const std = @import("std");
const argsAlloc = std.process.argsAlloc;
const argsFree = std.process.argsFree;
const c_allocator = std.heap.c_allocator;
const exit = std.process.exit;
const print = std.debug.print;
const printf = std.c.printf;

const failed = @import("base.zig").failed;
const serialize = @import("base.zig").serialize;

const core = @import("lexbor").core;
const html = @import("lexbor").html;

fn usage() void {
    print("Usage:\n", .{});
    print("    zig build html-parse -- <file>:\n", .{});
}

pub fn main() !void {}
