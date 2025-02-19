pub const core = @import("core_ext.zig");
pub const tag = @import("tag_ext.zig");

// pub const Id = @import("tag/Id.zig");
// pub const Id = @import("tag/Id.zig");
// pub const nameById = @import("tag_ext.zig").lxb_tag_name_by_id;

pub const Id = @import("tag_ext.zig").lxb_tag_id_enum_t;

pub fn nameById(tag_id: Id, len: ?*usize) ?*core.lxb_char_t {
    const ret = tag.lxb_tag_name_by_id(@intCast(@intFromEnum(tag_id)), len);
    return ret;
}
