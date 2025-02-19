const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;
const print = std.debug.print;
const assert = std.debug.assert;
const expect = std.testing.expect;

pub fn main() !void {
    // const html = [_][]const u8{
    //     "aaaa",
    //     "aaaa",
    // };
    //
    // for (html) |h| {
    //     print("{s}\n", .{h});
    // }
    const s = "punks";
    const p: [*]const u8 = s.ptr;
    print("{s}\n", .{&p[0]});
}
// zig test filename.zig
test "if" {
    try expect(1 == 1);
}
//  const stdout = std.io.getStdOut().writer();
//  const message: []const u8 = "Hello, World!";
//  try stdout.print("{s}\n", .{message});
