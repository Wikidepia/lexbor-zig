const lexbor_str_t = @import("./core_ext.zig").lexbor_str_t;
const lxb_status_t = @import("./core_ext.zig").lxb_status_t;
const lxb_char_t = @import("./core_ext.zig").lxb_char_t;
const lexbor_mraw_t = @import("./core_ext.zig").lexbor_mraw_t;
const lexbor_action_t = @import("./core_ext.zig").lexbor_action_t;
const lexbor_hash_t = @import("./core_ext.zig").lexbor_hash_t;
const lexbor_hash_entry_t = @import("./core_ext.zig").lexbor_hash_entry_t;
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
const lxb_tag_id_t = @import("./tag_ext.zig").lxb_tag_id_t;
const lxb_ns_id_t = @import("./ns_ext.zig").lxb_ns_id_t;

// dom/interfaces/document.h

pub const lxb_dom_document_cmode_t = enum(c_int) {
    LXB_DOM_DOCUMENT_CMODE_NO_QUIRKS = 0x00,
    LXB_DOM_DOCUMENT_CMODE_QUIRKS = 0x01,
    LXB_DOM_DOCUMENT_CMODE_LIMITED_QUIRKS = 0x02,
};

pub const lxb_dom_document_dtype_t = enum(c_int) {
    LXB_DOM_DOCUMENT_DTYPE_UNDEF = 0x00,
    LXB_DOM_DOCUMENT_DTYPE_HTML = 0x01,
    LXB_DOM_DOCUMENT_DTYPE_XML = 0x02,
};

pub const lxb_dom_document = extern struct {
    node: lxb_dom_node_t,

    compat_mode: lxb_dom_document_cmode_t,
    type: lxb_dom_document_dtype_t,

    doctype: ?*lxb_dom_document_type_t,
    element: ?*lxb_dom_element_t,

    create_interface: lxb_dom_interface_create_f,
    clone_interface: lxb_dom_interface_clone_f,
    destroy_interface: lxb_dom_interface_destroy_f,

    ev_insert: lxb_dom_event_insert_f,
    ev_remove: lxb_dom_event_remove_f,
    ev_destroy: lxb_dom_event_destroy_f,
    ev_set_value: lxb_dom_event_set_value_f,

    mraw: ?*lexbor_mraw_t,
    text: ?*lexbor_mraw_t,
    tags: ?*lexbor_hash_t,
    attrs: ?*lexbor_hash_t,
    prefix: ?*lexbor_hash_t,
    ns: ?*lexbor_hash_t,
    parser: ?*anyopaque,
    user: ?*anyopaque,

    tags_inherited: bool,
    ns_inherited: bool,

    scripting: bool,
};

// dom/interfaces/node.h

pub const lxb_dom_node_simple_walker_f = ?*const fn (node: ?*lxb_dom_node_t, ctx: ?*anyopaque) lexbor_action_t;

pub const lxb_dom_node_type_t = enum(c_int) {
    LXB_DOM_NODE_TYPE_UNDEF = 0x00,
    LXB_DOM_NODE_TYPE_ELEMENT = 0x01,
    LXB_DOM_NODE_TYPE_ATTRIBUTE = 0x02,
    LXB_DOM_NODE_TYPE_TEXT = 0x03,
    LXB_DOM_NODE_TYPE_CDATA_SECTION = 0x04,
    LXB_DOM_NODE_TYPE_ENTITY_REFERENCE = 0x05, // historical
    LXB_DOM_NODE_TYPE_ENTITY = 0x06, // historical
    LXB_DOM_NODE_TYPE_PROCESSING_INSTRUCTION = 0x07,
    LXB_DOM_NODE_TYPE_COMMENT = 0x08,
    LXB_DOM_NODE_TYPE_DOCUMENT = 0x09,
    LXB_DOM_NODE_TYPE_DOCUMENT_TYPE = 0x0A,
    LXB_DOM_NODE_TYPE_DOCUMENT_FRAGMENT = 0x0B,
    LXB_DOM_NODE_TYPE_NOTATION = 0x0C, // historical
    LXB_DOM_NODE_TYPE_LAST_ENTRY = 0x0D,
};

pub const lxb_dom_node = extern struct {
    event_target: lxb_dom_event_target_t,

    local_name: usize,
    prefix: usize,
    ns: usize,

    owner_document: ?*lxb_dom_document_t,

    next: ?*lxb_dom_node_t,
    prev: ?*lxb_dom_node_t,
    parent: ?*lxb_dom_node_t,
    first_child: ?*lxb_dom_node_t,
    last_child: ?*lxb_dom_node_t,
    user: ?*anyopaque,

    type: lxb_dom_node_type_t,

    // #ifdef LXB_DOM_NODE_USER_VARIABLES
    //     LXB_DOM_NODE_USER_VARIABLES
    // #endif /* LXB_DOM_NODE_USER_VARIABLES */
};

// dom/interface.h

pub const lxb_dom_event_target_t = lxb_dom_event_target;
pub const lxb_dom_node_t = lxb_dom_node;
pub const lxb_dom_element_t = lxb_dom_element;
pub const lxb_dom_attr_t = lxb_dom_attr;
pub const lxb_dom_document_t = lxb_dom_document;
pub const lxb_dom_document_type_t = lxb_dom_document_type;
pub const lxb_dom_document_fragment_t = lxb_dom_document_fragment;
pub const lxb_dom_shadow_root_t = lxb_dom_shadow_root;
pub const lxb_dom_character_data_t = lxb_dom_character_data;
pub const lxb_dom_text_t = lxb_dom_text;
pub const lxb_dom_cdata_section_t = lxb_dom_cdata_section;
pub const lxb_dom_processing_instruction_t = lxb_dom_processing_instruction;
pub const lxb_dom_comment_t = lxb_dom_comment;

pub const lxb_dom_interface_t = void;

pub const lxb_dom_interface_constructor_f = ?*const fn (document: ?*anyopaque) ?*anyopaque;

pub const lxb_dom_interface_destructor_f = ?*const fn (intrfc: ?*anyopaque) ?*anyopaque;

pub const lxb_dom_interface_create_f = ?*const fn (document: ?*lxb_dom_document_t, tag_id: lxb_tag_id_t, ns: lxb_ns_id_t) ?*lxb_dom_interface_t;

pub const lxb_dom_interface_clone_f = ?*const fn (document: ?*lxb_dom_document_t, intrfc: ?*const lxb_dom_interface_t) ?*lxb_dom_interface_t;

pub const lxb_dom_interface_destroy_f = ?*const fn (intrfc: ?*lxb_dom_interface_t) ?*lxb_dom_interface_t;

pub const lxb_dom_event_insert_f = ?*const fn (node: ?*lxb_dom_node_t) lxb_status_t;

pub const lxb_dom_event_remove_f = ?*const fn (node: ?*lxb_dom_node_t) lxb_status_t;

pub const lxb_dom_event_destroy_f = ?*const fn (node: ?*lxb_dom_node_t) lxb_status_t;

pub const lxb_dom_event_set_value_f = ?*const fn (node: ?*lxb_dom_node_t, value: ?*const lxb_char_t, length: usize) lxb_status_t;

// dom/interfaces/event_target.h

pub const lxb_dom_event_target = extern struct {
    events: ?*anyopaque,
};

// dom/interfaces/element.h

pub const lxb_dom_element_custom_state_t = enum(c_int) {
    LXB_DOM_ELEMENT_CUSTOM_STATE_UNDEFINED = 0x00,
    LXB_DOM_ELEMENT_CUSTOM_STATE_FAILED = 0x01,
    LXB_DOM_ELEMENT_CUSTOM_STATE_UNCUSTOMIZED = 0x02,
    LXB_DOM_ELEMENT_CUSTOM_STATE_CUSTOM = 0x03,
};

pub const lxb_dom_element = extern struct {
    node: lxb_dom_node_t,
    upper_name: lxb_dom_attr_id_t,
    qualified_name: lxb_dom_attr_id_t,
    is_value: ?*lexbor_str_t,
    first_attr: ?*lxb_dom_attr_t,
    last_attr: ?*lxb_dom_attr_t,
    attr_id: ?*lxb_dom_attr_t,
    attr_class: ?*lxb_dom_attr_t,
    custom_state: lxb_dom_element_custom_state_t,
};

// dom/interfaces/attr.h

pub const lxb_dom_attr_data_t = extern struct {
    entry: lexbor_hash_entry_t,
    attr_id: lxb_dom_attr_id_t,
    ref_count: usize,
    read_only: bool,
};

pub const lxb_dom_attr = extern struct {
    node: lxb_dom_node_t,
    upper_name: lxb_dom_attr_id_t,
    qualified_name: lxb_dom_attr_id_t,
    value: ?*lexbor_str_t,
    owner: ?*lxb_dom_element_t,
    next: ?*lxb_dom_attr_t,
    prev: ?*lxb_dom_attr_t,
};

// dom/interfaces/attr_const.h

pub const lxb_dom_attr_id_t = usize;

pub const lxb_dom_attr_id_enum_t = enum(c_int) {
    LXB_DOM_ATTR__UNDEF = 0x0000,
    LXB_DOM_ATTR_ACTIVE = 0x0001,
    LXB_DOM_ATTR_ALT = 0x0002,
    LXB_DOM_ATTR_CHARSET = 0x0003,
    LXB_DOM_ATTR_CHECKED = 0x0004,
    LXB_DOM_ATTR_CLASS = 0x0005,
    LXB_DOM_ATTR_COLOR = 0x0006,
    LXB_DOM_ATTR_CONTENT = 0x0007,
    LXB_DOM_ATTR_DIR = 0x0008,
    LXB_DOM_ATTR_DISABLED = 0x0009,
    LXB_DOM_ATTR_FACE = 0x000a,
    LXB_DOM_ATTR_FOCUS = 0x000b,
    LXB_DOM_ATTR_FOR = 0x000c,
    LXB_DOM_ATTR_HEIGHT = 0x000d,
    LXB_DOM_ATTR_HOVER = 0x000e,
    LXB_DOM_ATTR_HREF = 0x000f,
    LXB_DOM_ATTR_HTML = 0x0010,
    LXB_DOM_ATTR_HTTP_EQUIV = 0x0011,
    LXB_DOM_ATTR_ID = 0x0012,
    LXB_DOM_ATTR_IS = 0x0013,
    LXB_DOM_ATTR_MAXLENGTH = 0x0014,
    LXB_DOM_ATTR_PLACEHOLDER = 0x0015,
    LXB_DOM_ATTR_POOL = 0x0016,
    LXB_DOM_ATTR_PUBLIC = 0x0017,
    LXB_DOM_ATTR_READONLY = 0x0018,
    LXB_DOM_ATTR_REQUIRED = 0x0019,
    LXB_DOM_ATTR_SCHEME = 0x001a,
    LXB_DOM_ATTR_SELECTED = 0x001b,
    LXB_DOM_ATTR_SIZE = 0x001c,
    LXB_DOM_ATTR_SLOT = 0x001d,
    LXB_DOM_ATTR_SRC = 0x001e,
    LXB_DOM_ATTR_STYLE = 0x001f,
    LXB_DOM_ATTR_SYSTEM = 0x0020,
    LXB_DOM_ATTR_TITLE = 0x0021,
    LXB_DOM_ATTR_TYPE = 0x0022,
    LXB_DOM_ATTR_WIDTH = 0x0023,
    LXB_DOM_ATTR__LAST_ENTRY = 0x0024,
};

// dom/interfaces/document_type.h

pub const lxb_dom_document_type = extern struct {
    node: lxb_dom_node_t,
    name: lxb_dom_attr_id_t,
    public_id: lexbor_str_t,
    system_id: lexbor_str_t,
};

// dom/interfaces/document_fragment.h

pub const lxb_dom_document_fragment = extern struct {
    node: lxb_dom_node_t,
    host: ?*lxb_dom_element_t,
};

// dom/interfaces/character_data.h

pub const lxb_dom_character_data = extern struct {
    node: lxb_dom_node_t,
    data: lexbor_str_t,
};

// dom/interfaces/cdata_section.h

pub const lxb_dom_cdata_section = extern struct {
    text: lxb_dom_text_t,
};

// dom/interfaces/comment.h

pub const lxb_dom_comment = extern struct {
    char_data: lxb_dom_character_data_t,
};

// dom/interfaces/shadow_root.h

pub const lxb_dom_shadow_root_mode_t = enum(c_int) {
    LXB_DOM_SHADOW_ROOT_MODE_OPEN = 0x00,
    LXB_DOM_SHADOW_ROOT_MODE_CLOSED = 0x01,
};

pub const lxb_dom_shadow_root = extern struct {
    document_fragment: lxb_dom_document_fragment_t,
    mode: lxb_dom_shadow_root_mode_t,
    host: ?*lxb_dom_element_t,
};

// dom/interfaces/text.h

pub const lxb_dom_text = extern struct {
    char_data: lxb_dom_character_data_t,
};

// dom/interfaces/processing_instruction.h

pub const lxb_dom_processing_instruction = extern struct {
    char_data: lxb_dom_character_data_t,
    target: lexbor_str_t,
};
