const std = @import("std");
const print = std.debug.print;

const serialize = @import("base.zig").serialize;
const serializeNode = @import("base.zig").serializeNode;

const dom = @import("lexbor").dom;
const html = @import("lexbor").html;
const tag = @import("lexbor").tag;

pub fn main() !void {
    var tag_name_len: usize = undefined;

    const input = "";

    // Initialization
    const parser = try html.parser.create();
    defer html.parser.destroy(parser);

    try html.parser.init(parser);

    // Parse
    const doc = try html.parser.parse(parser, input, input.len);
    defer html.document.destroy(doc);

    const body = html.document.bodyElement(doc);

    var cur: tag.IdEnum = .a;
    const last: tag.IdEnum = ._last_entry;

    while (@intFromEnum(cur) < @intFromEnum(last)) : (cur = @enumFromInt(@intFromEnum(cur) + 1)) {
        const tag_name = try tag.nameById(cur, &tag_name_len);
        const element = try dom.document.createElement(&doc.dom_document, tag_name, tag_name_len, null);

        if (html.tag.isVoid(cur)) {
            print("Create element by tag name \"{s}\"\n", .{tag_name});
        } else {
            print("Create element by tag name \"{s}\" and append text node\n", .{tag_name});
            const text = try dom.document.createTextNode(&doc.dom_document, tag_name, tag_name_len);
            dom.node.insertChild(dom.interface.node(element), dom.interface.node(text));
        }
        serializeNode(dom.interface.node(element));
        dom.node.insertChild(dom.interface.node(body), dom.interface.node(element));
    }
    // Print Result
    serialize(dom.interface.node(doc));
}
