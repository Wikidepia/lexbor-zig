const core = @import("core_ext.zig");
const tag = @import("tag_ext.zig");

pub const IdEnum = @import("tag_ext.zig").lxb_tag_id_enum_t;

// pub fn nameById(tag_id: tag.lxb_tag_id_enum_t, len: ?*usize) ?[*:0]core.lxb_char_t {
pub fn nameById(tag_id: IdEnum, len: ?*usize) ?[*:0]core.lxb_char_t {
    const ret = tag.lxb_tag_name_by_id(@intCast(@intFromEnum(tag_id)), len);
    return ret;
}
