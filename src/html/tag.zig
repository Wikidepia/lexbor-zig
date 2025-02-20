const html = @import("../html_ext.zig");
const tag = @import("../tag_ext.zig");

// pub const IdEnum = @import("../tag.zig").IdEnum;

pub fn isVoid(tag_id: tag.lxb_tag_id_enum_t) bool {
    return html.lxb_html_tag_is_void(@intCast(@intFromEnum(tag_id)));
}
