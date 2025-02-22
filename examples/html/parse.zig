const std = @import("std");
const print = std.debug.print;

const serialize = @import("base.zig").serialize;

const core = @import("lexbor").core;
const dom = @import("lexbor").dom;
const html = @import("lexbor").html;

pub fn main() !void {
    const input = "<div><p>blah-blah-blah</div>";

    // Initialization
    const doc = html.document.create();
    if (doc == null) return error.FailedToCreate;
    defer _ = html.document.destroy(doc);

    // Parse HTML
    const status = html.document.parse(doc, input, input.len);
    if (status != core.Status.ok) return error.FailedToParse;

    // Print Incoming Data
    print("HTML:\n", .{});
    print("{s}\n", .{input});

    // Print Result
    print("\nHTML Tree:\n", .{});
    serialize(dom.interface.node(doc));
}
