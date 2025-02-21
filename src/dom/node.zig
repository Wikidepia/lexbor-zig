// const std = @import("std");

pub const dom = @import("../dom_ext.zig");

pub const node = dom.lxb_dom_node_t;

pub fn insertChild(to: ?*dom.lxb_dom_node_t, node_: ?*dom.lxb_dom_node_t) void {
    dom.lxb_dom_node_insert_child(to, node_);
}
