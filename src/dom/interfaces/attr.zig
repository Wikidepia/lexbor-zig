const std = @import("std");
const sliceTo = std.mem.sliceTo;

pub const core = @import("../../core_ext.zig");
pub const dom = @import("../../dom_ext.zig");

pub const Attr = dom.lxb_dom_attr_t;

pub fn qualifiedName(attr: ?*dom.lxb_dom_attr_t, len: ?*usize) ?[]const u8 {
    const qn = dom.lxb_dom_attr_qualified_name(attr, len);
    return sliceTo(@as([*:0]const u8, @ptrCast(qn)), 0);
}

pub fn value(attr: ?*dom.lxb_dom_attr_t, len: ?*usize) ?[]const u8 {
    const v = dom.lxb_dom_attr_value(attr, len);
    return sliceTo(@as([*:0]const u8, @ptrCast(v)), 0);
}

pub fn setValue(attr: ?*dom.lxb_dom_attr_t, value_: []const u8, value_len: usize) core.lexbor_status_t {
    const status = dom.lxb_dom_attr_set_value(attr, @ptrCast(value_.ptr), value_len);
    return @enumFromInt(status);
}
