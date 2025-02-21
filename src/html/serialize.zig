const core = @import("../core_ext.zig");
const html = @import("../html_ext.zig");
const dom = @import("../dom_ext.zig");

pub const Opt = html.lxb_html_serialize_opt;

pub fn prettyTreeCb(node: ?*dom.lxb_dom_node_t, opt: Opt, indent: usize, cb: html.lxb_html_serialize_cb_f, ctx: ?*anyopaque) core.lexbor_status_t {
    const status = html.lxb_html_serialize_pretty_tree_cb(node, @intFromEnum(opt), indent, cb, ctx);
    return @enumFromInt(status);
}

pub fn prettyCb(node: ?*dom.lxb_dom_node_t, opt: Opt, indent: usize, cb: html.lxb_html_serialize_cb_f, ctx: ?*anyopaque) core.lexbor_status_t {
    const status = html.lxb_html_serialize_pretty_cb(node, @intFromEnum(opt), indent, cb, ctx);
    return @enumFromInt(status);
}
