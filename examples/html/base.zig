const std = @import("std");
const panic = std.debug.panic;
const print = std.debug.print;

const core = @import("lexbor").core;
const html = @import("lexbor").html;
const dom = @import("lexbor").dom;

pub fn serialize(node: *dom.NodeType) void {
    const status = html.serialize.prettyTreeCb(node, html.serialize.Opt.undef, 0, serializerCallback, null);

    if (status != core.Status.ok) {
        panic("Failed to serialization HTML tree", .{});
    }
}

pub fn serializeNode(node: *dom.NodeType) void {
    const status = html.serialize.prettyCb(node, html.serialize.Opt.undef, 0, serializerCallback, null);

    if (status != core.Status.ok) {
        panic("Failed to serialization HTML tree", .{});
    }
}

fn serializerCallback(data: ?[*:0]const core.CharType, len: usize, ctx: ?*anyopaque) callconv(.C) core.StatusType {
    _ = ctx;
    _ = len;
    print("{s}", .{data.?});
    return @intFromEnum(core.Status.ok);
}
