pub const dom = @import("../dom_ext.zig");

pub inline fn node(obj: anytype) *dom.lxb_dom_node_t {
    return @as(*dom.lxb_dom_node_t, @ptrCast(obj));
}
