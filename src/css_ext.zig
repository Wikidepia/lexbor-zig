const lexbor_dobject_t = @import("./core_ext.zig").lexbor_dobject_t;
const lexbor_mraw_t = @import("./core_ext.zig").lexbor_mraw_t;
const lexbor_str_t = @import("./core_ext.zig").lexbor_str_t;
const lxb_status_t= @import("./core_ext.zig").lxb_status_t;
const lxb_char_t= @import("./core_ext.zig").lxb_char_t;
const lexbor_array_obj_t=@import("./core_ext.zig").lexbor_array_obj_t; 
// css/base.h

pub const LEXBOR_CSS_VERSION_MAJOR = 1;
pub const LEXBOR_CSS_VERSION_MINOR = 2;
pub const LEXBOR_CSS_VERSION_PATCH = 0;
pub const LEXBOR_CSS_VERSION_STRING = "1.2.0";

pub const lxb_css_memory_t = extern struct {
    objs: ?*lexbor_dobject_t,
    mraw: ?*lexbor_mraw_t,
    tree: ?*lexbor_mraw_t,
};

pub const lxb_css_type_t = u32;

pub const lxb_css_parser_t = lxb_css_parser ;
pub const lxb_css_parser_state_t = lxb_css_parser_state ;
pub const lxb_css_parser_error_t = lxb_css_parser_error ;

pub const lxb_css_syntax_tokenizer_t = lxb_css_syntax_tokenizer ;
pub const lxb_css_syntax_token_t = lxb_css_syntax_token ;

pub const lxb_css_parser_state_f = ?*const fn (parser: ?*lxb_css_parser_t, token: ?*const lxb_css_syntax_token_t, ctx: ?*anyopaque) callconv(.C) bool;

pub const lxb_css_style_create_f = ?*const fn (memory: ?*lxb_css_memory_t) callconv(.C) ?*anyopaque;

pub const lxb_css_style_serialize_f = ?*const fn (style:?*const anyopaque, cb: lexbor_serialize_cb_f, ctx: ?*anyopaque) callconv(.C) lxb_status_t;

pub const lxb_css_style_destroy_f = ?*const fn (memory: ?*lxb_css_memory_t, style:?*anyopaque, self_destroy:bool) callconv(.C) ?*anyopaque;

pub const lxb_css_stylesheet_t=lxb_css_stylesheet ;
pub const lxb_css_rule_list_t=lxb_css_rule_list ;
pub const lxb_css_rule_style_t=lxb_css_rule_style ;
pub const lxb_css_rule_bad_style_t=lxb_css_rule_bad_style ;
pub const lxb_css_rule_declaration_list_t=lxb_css_rule_declaration_list ;
pub const lxb_css_rule_declaration_t=lxb_css_rule_declaration ;
pub const lxb_css_rule_at_t=lxb_css_rule_at ;

pub const lxb_css_entry_data_t = extern struct {
    name: lxb_char_t,
    length: usize,
    unique: usize,
    state: lxb_css_parser_state_f,
    create: lxb_css_style_create_f,
    destroy: lxb_css_style_destroy_f,
    serialize: lxb_css_style_serialize_f,
    initial:?*anyopaque,
};

pub const lxb_css_data_t = extern struct {
    name: ?*lxb_char_t,
    length: usize,
    unique: usize,
};

// css/selectors/base.h

pub const lxb_css_selectors_t = lxb_css_selectors;
pub const lxb_css_selector_t = lxb_css_selector;
pub const lxb_css_selector_list_t = lxb_css_selector_list;

// css/selectors/selectors.h

pub const lxb_css_selectors = extern struct {
    // TODO
    list: ?*lxb_css_selector_list_t,
    list_last: ?*lxb_css_selector_list_t,
    parent: ?*lxb_css_selector_t,
    combinator: lxb_css_selector_combinator_t,
    comb_default: lxb_css_selector_combinator_t,
    @"error": usize,
    status: bool,
    err_in_function: bool,
    failed: bool,
};

// css/selectors/selector.h

pub const lxb_css_selector_type_t = enum(c_int) {
    LXB_CSS_SELECTOR_TYPE__UNDEF = 0x00,
    LXB_CSS_SELECTOR_TYPE_ANY,
    LXB_CSS_SELECTOR_TYPE_ELEMENT, // div, tag name <div>
    LXB_CSS_SELECTOR_TYPE_ID, // #hash
    LXB_CSS_SELECTOR_TYPE_CLASS, // .class
    LXB_CSS_SELECTOR_TYPE_ATTRIBUTE, // [key=val], <... key="val">
    LXB_CSS_SELECTOR_TYPE_PSEUDO_CLASS, // :pseudo
    LXB_CSS_SELECTOR_TYPE_PSEUDO_CLASS_FUNCTION, // :function(...)
    LXB_CSS_SELECTOR_TYPE_PSEUDO_ELEMENT, // ::pseudo */
    LXB_CSS_SELECTOR_TYPE_PSEUDO_ELEMENT_FUNCTION, // ::function(...)
    LXB_CSS_SELECTOR_TYPE__LAST_ENTRY,
};

pub const lxb_css_selector_combinator_t = enum(c_int) {
    LXB_CSS_SELECTOR_COMBINATOR_DESCENDANT = 0x00, // WHITESPACE
    LXB_CSS_SELECTOR_COMBINATOR_CLOSE, // two compound selectors [key=val].foo
    LXB_CSS_SELECTOR_COMBINATOR_CHILD, // '>'
    LXB_CSS_SELECTOR_COMBINATOR_SIBLING, // '+'
    LXB_CSS_SELECTOR_COMBINATOR_FOLLOWING, // '~'
    LXB_CSS_SELECTOR_COMBINATOR_CELL, // '||'
    LXB_CSS_SELECTOR_COMBINATOR__LAST_ENTRY,
};

pub const lxb_css_selector_match_t = enum(c_int) {
    LXB_CSS_SELECTOR_MATCH_EQUAL = 0x00, //  =
    LXB_CSS_SELECTOR_MATCH_INCLUDE, // ~=
    LXB_CSS_SELECTOR_MATCH_DASH, // |=
    LXB_CSS_SELECTOR_MATCH_PREFIX, // ^=
    LXB_CSS_SELECTOR_MATCH_SUFFIX, // $=
    LXB_CSS_SELECTOR_MATCH_SUBSTRING, // *=
    LXB_CSS_SELECTOR_MATCH__LAST_ENTRY,
};

pub const lxb_css_selector_modifier_t = enum(c_int) {
    LXB_CSS_SELECTOR_MODIFIER_UNSET = 0x00,
    LXB_CSS_SELECTOR_MODIFIER_I,
    LXB_CSS_SELECTOR_MODIFIER_S,
    LXB_CSS_SELECTOR_MODIFIER__LAST_ENTRY,
};

pub const lxb_css_selector_attribute_t = extern struct {
    match: lxb_css_selector_match_t,
    modifier: lxb_css_selector_modifier_t,
    value: lexbor_str_t,
};

pub const lxb_css_selector_pseudo_t = extern struct {
    type: c_uint,
    data: ?*anyopaque,
};

pub const lxb_css_selector = extern struct {
    type: lxb_css_selector_type_t,
    combinator: lxb_css_selector_combinator_t,
    name: lexbor_str_t,
    ns: lexbor_str_t,
    u: extern union {
        attribute: lxb_css_selector_attribute_t,
        pseudo: lxb_css_selector_pseudo_t,
    },
    next: ?*lxb_css_selector_t,
    prev: ?*lxb_css_selector_t,
    list: ?*lxb_css_selector_list_t,
};

pub const lxb_css_selector_list = extern struct {
    first: ?*lxb_css_selector_t,
    last: ?*lxb_css_selector_t,
    parent: ?*lxb_css_selector_t,
    next: ?*lxb_css_selector_list,
    prev: ?*lxb_css_selector_list,
    memory: ?*lxb_css_memory_t,
    specificity: ?*lxb_css_selector_specificity_t,
};

pub const lxb_css_selector_specificity_t = u32;

// css/parser.h

pub const LXB_CSS_SYNTAX_PARSER_ERROR_UNDEF = 0x0000;
// eof-in-at-rule
pub const LXB_CSS_SYNTAX_PARSER_ERROR_EOINATRU = 0x0001;
// eof-in-qualified-rule
pub const LXB_CSS_SYNTAX_PARSER_ERROR_EOINQURU = 0x0002;
// eof-in-simple-block
pub const LXB_CSS_SYNTAX_PARSER_ERROR_EOINSIBL = 0x0003;
// eof-in-function
pub const LXB_CSS_SYNTAX_PARSER_ERROR_EOINFU = 0x0004;
// eof-before-parse-rule
pub const LXB_CSS_SYNTAX_PARSER_ERROR_EOBEPARU = 0x0005;
// unexpected-token-after-parse-rule
pub const LXB_CSS_SYNTAX_PARSER_ERROR_UNTOAFPARU = 0x0006;
// eof-before-parse-component-value
pub const LXB_CSS_SYNTAX_PARSER_ERROR_EOBEPACOVA = 0x0007;
// unexpected-token-after-parse-component-value
pub const LXB_CSS_SYNTAX_PARSER_ERROR_UNTOAFPACOVA = 0x0008;
// unexpected-token-in-declaration
pub const LXB_CSS_SYNTAX_PARSER_ERROR_UNTOINDE = 0x0009;

pub const lxb_css_parser_stage_t = enum(c_int) {
    LXB_CSS_PARSER_CLEAN = 0,
    LXB_CSS_PARSER_RUN,
    LXB_CSS_PARSER_STOP,
    LXB_CSS_PARSER_END,
};

pub const lxb_css_parser = extern struct{
    block: lxb_css_parser_state_f,
    context: ?*anyopaque,
    tkz: ?*lxb_css_syntax_tokenizer_t,
    selectors: ?* lxb_css_selectors_t,
    old_selectors: ?* lxb_css_selectors_t,
    memory: ?* lxb_css_memory_t,
    old_memory: ?* lxb_css_memory_t,
    // TODO
    rules_begin: ?*lxb_css_syntax_rule_t,
    rules_end: ?*lxb_css_syntax_rule_t,
    rules: ?*lxb_css_syntax_rule_t,
};

pub const lxb_css_parser_state = extern struct{
    state:lxb_css_parser_state_f,
    context: ?*anyopaque,
    root:bool,
};

pub const lxb_css_parser_error = extern struct{
    message:lexbor_str_t,
};

// css/syntax/tokenizer.h

pub const lxb_css_syntax_tokenizer_state_f = ?*const fn (tkz: ?*lxb_css_syntax_tokenizer_t, token: ?*lxb_css_syntax_token_t, data: ?*const lxb_char_t, end: ?*const lxb_char_t) callconv(.C) ?*lxb_char_t;

pub const lxb_css_syntax_tokenizer_chunk_f = ?*const fn (tkz: ?*lxb_css_syntax_tokenizer_t,  data: ?*const  ?*lxb_char_t, end: ?*const ?* lxb_char_t, ctx: ?*anyopaque) callconv(.C) lxb_status_t;

pub const  lxb_css_syntax_tokenizer_opt = enum(c_int) {
    LXB_CSS_SYNTAX_TOKENIZER_OPT_UNDEF = 0x00,
};

pub const lxb_css_syntax_tokenizer_cache_t = extern struct{
    list:?*?*lxb_css_syntax_token_t,
    size:usize,
    length:usize,
};

pub const lxb_css_syntax_tokenizer = extern struct{
    cache:?*lxb_css_syntax_tokenizer_cache_t,
    tokens:?*lexbor_dobject_t,
    parse_errors:lexbor_array_obj_t,
    in_begin: ?*const lxb_char_t,
    in_end: ?*const lxb_char_t,
    begin: ?*const lxb_char_t,
    offset: usize,
    cache_pos:usize,
    prepared:usize,
    mraw:?*lexbor_mraw_t,
    chunk_cb:lxb_css_syntax_tokenizer_chunk_f,
    chunk_ctx:?*anyopaque,
    start:?*lxb_char_t,
    pos:?*lxb_char_t,
    end:?*const lxb_char_t,
    buffer: [128]lxb_char_t,
    token_data: lxb_css_syntax_token_data_t,
    opt:c_uint,
    status: lxb_status_t,
    eof:bool,
    with_comment:bool,
};


// css/syntax/token.h

pub const lxb_css_syntax_token_data_t = lxb_css_syntax_token_data;

pub const lxb_css_syntax_token_data_cb_f = ?*const fn (begin: ?*const lxb_char_t,  end: ?*const  ?*lxb_char_t, str: ?*lexbor_str_t, mraw: ?*lexbor_mraw_t, td: ?*lxb_css_syntax_token_data_t) callconv(.C) ?*lxb_char_t;

pub const lxb_css_syntax_token_data = extern struct{
    cb: lxb_css_syntax_token_data_cb_f,
    status:lxb_status_t,
    count: c_int,
    num: u32,
    is_last: bool,
};

// css/syntax/syntax.h

pub const lxb_css_syntax_rule_t =lxb_css_syntax_rule;

pub const lxb_css_syntax_state_f = ?*const fn (parser: ?*lxb_css_parser_t,  token: ?*const  ?*lxb_css_syntax_token_t, rule: ?*lxb_css_syntax_rule) callconv(.C) ?*lxb_css_syntax_token_t;

pub const lxb_css_syntax_declaration_end_f = ?*const fn (parser: ?*lxb_css_parser_t, ctx:?*anyopaque, important:bool, failed:bool) callconv(.C) ?*lxb_status_t;

pub const lxb_css_syntax_cb_done_f = ?*const fn (parser: ?*lxb_css_parser_t, token:?*const lxb_css_syntax_token_t, ctx:?*anyopaque,  failed:bool) callconv(.C) ?*lxb_status_t;

pub const lxb_css_syntax_list_rules_offset_t = extern struct {
    begin: usize,
    end :usize,
};

pub const lxb_css_syntax_at_rules_offset_t = extern struct {
    name: usize,
    prelude :usize,
    prelude_end :usize,
    block :usize,
    block_end :usize,
};

pub const lxb_css_syntax_qualified_offset_t=extern struct {
    prelude: usize,
    prelude_end :usize,
    block :usize,
    block_end :usize,
};

pub const lxb_css_syntax_declarations_offset_t=extern struct {
    begin :usize,
    end :usize,
    name_begin :usize,
    name_end :usize,
    value_begin :usize,
    before_important :usize,
    value_end :usize,
};

pub const lxb_css_syntax_cb_base_t=extern struct {
    state: lxb_css_parser_state_f,
    block: lxb_css_parser_state_f,
    failed: lxb_css_parser_state_f,
    end: lxb_css_syntax_cb_done_f,
};

pub const lxb_css_syntax_cb_pipe_t  = lxb_css_syntax_cb_base_t ;
pub const lxb_css_syntax_cb_block_t=lxb_css_syntax_cb_base_t ;
pub const lxb_css_syntax_cb_function_t=lxb_css_syntax_cb_base_t ;
pub const lxb_css_syntax_cb_components_t=lxb_css_syntax_cb_base_t ;
pub const lxb_css_syntax_cb_at_rule_t=lxb_css_syntax_cb_base_t ;
pub const lxb_css_syntax_cb_qualified_rule_t=lxb_css_syntax_cb_base_t ;

pub const lxb_css_syntax_cb_declarations_t=extern struct {
    cb: lxb_css_syntax_cb_base_t,
    declaration_end: lxb_css_syntax_declaration_end_f,
    at_rule: ?*const lxb_css_syntax_cb_at_rule_t,
};

// ここから: https://github.com/lexbor/lexbor/blob/v2.4.0/source/lexbor/css/syntax/syntax.h
