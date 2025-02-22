pub const core = @import("../../core_ext.zig");
pub const dom = @import("../../dom_ext.zig");

pub fn byTagName(root: ?*dom.lxb_dom_element_t, collection: ?*dom.lxb_dom_collection_t, qualified_name: []const u8, len: usize) core.lexbor_status_t {
    return dom.lxb_dom_elements_by_tag_name(root, collection, @ptrCast(qualified_name.ptr), len);
}
