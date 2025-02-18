// const lexbor_str_t  = @import("./core_ext.zig").lexbor_str_t;
// const lxb_status_t = @import("./core_ext.zig").lxb_status_t;
// const lxb_char_t = @import("./core_ext.zig").lxb_char_t;
// const lexbor_mraw_t = @import("./core_ext.zig").lexbor_mraw_t;
// const lexbor_action_t = @import("./core_ext.zig").lexbor_action_t;
// const lexbor_hash_t = @import("./core_ext.zig").lexbor_hash_t;
// const lexbor_avl_t = @import("./core_ext.zig").lexbor_avl_t;
// const lexbor_array_t = @import("./core_ext.zig").lexbor_array_t;
// const lexbor_hash_t = @import("./core_ext.zig").lexbor_hash_t;
// const lexbor_dobject_t = @import("./core_ext.zig").lexbor_dobject_t;
// const lxb_css_memory_t = @import("./css_ext.zig").lxb_css_memory_t;
// const lxb_css_selectors_t = @import("./css_ext.zig").lxb_css_selectors_t;
// const lxb_css_parser_t = @import("./css_ext.zig").lxb_css_parser_t;
// const lxb_css_rule_declaration_t = @import("./css_ext.zig").lxb_css_rule_declaration_t;
// const lxb_css_selector_specificity_t= @import("./css_ext.zig").lxb_css_selector_specificity_t;
// const lxb_css_stylesheet_t= @import("./css_ext.zig").xb_css_stylesheet_t;
// const lxb_selectors_t = @import("./selectors_ext.zig").lxb_selectors_t;

// ns/const.h

pub const LXB_NS_CONST_VERSION = "253D4AFDA959234B48A478B956C3C777";

pub const lxb_ns_id_t = usize;
pub const lxb_ns_prefix_id_t = usize;

pub const lxb_ns_id_enum_t = enum(c_int) {
    LXB_NS__UNDEF = 0x00,
    LXB_NS__ANY = 0x01,
    LXB_NS_HTML = 0x02,
    LXB_NS_MATH = 0x03,
    LXB_NS_SVG = 0x04,
    LXB_NS_XLINK = 0x05,
    LXB_NS_XML = 0x06,
    LXB_NS_XMLNS = 0x07,
    LXB_NS__LAST_ENTRY = 0x08,
};
