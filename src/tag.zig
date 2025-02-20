const std = @import("std");
const sliceTo = std.mem.sliceTo;

const core = @import("core_ext.zig");
const tag = @import("tag_ext.zig");

pub const IdEnum = @import("tag_ext.zig").lxb_tag_id_enum_t;

// pub fn nameById(tag_id: tag.lxb_tag_id_enum_t, len: ?*usize) ?[*:0]core.lxb_char_t {

const Error = error{
    FailedToGetTagNameById,
};

// pub fn nameById(tag_id: IdEnum, len: ?*usize) ?[*:0]core.lxb_char_t {
pub fn nameById(tag_id: IdEnum, len: ?*usize) Error![]const u8 {
    const tag_name = tag.lxb_tag_name_by_id(@intCast(@intFromEnum(tag_id)), len) orelse return error.FailedToGetTagNameById;
    return sliceTo(@as([*:0]u8, @ptrCast(tag_name)), 0);
}
// lxb_html_tag_is_void
