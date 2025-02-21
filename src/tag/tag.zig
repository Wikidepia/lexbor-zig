const std = @import("std");
const sliceTo = std.mem.sliceTo;

const tag = @import("../tag_ext.zig");

pub fn nameById(tag_id: tag.lxb_tag_id_enum_t, len: ?*usize) ?[]const u8 {
    const tag_name = tag.lxb_tag_name_by_id(@intCast(@intFromEnum(tag_id)), len) orelse return null;
    return sliceTo(@as([*:0]u8, @ptrCast(tag_name)), 0);
}
