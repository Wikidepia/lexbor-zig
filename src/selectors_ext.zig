const lxb_status_t = @import("./core_ext.zig").lxb_status_t;
const lxb_css_selector_combinator_t =@import("./css_ext.zig").lxb_css_selector_combinator_t ; 
const lxb_css_selector_t =@import("./css_ext.zig").lxb_css_selector_t ; 
const lexbor_dobject_t = @import("./core_ext.zig").lexbor_dobject_t;
// selectors/selectors.h

pub const lxb_selectors_opt_t = enum(c_int) {
    LXB_SELECTORS_OPT_DEFAULT = 0x00,
    LXB_SELECTORS_OPT_MATCH_ROOT = 1 << 1,
    LXB_SELECTORS_OPT_MATCH_FIRST = 1 << 2,
};

pub const    lxb_selectors_t= lxb_selectors ;
pub const     lxb_selectors_entry_t=  lxb_selectors_entry ;
pub const   lxb_selectors_nested_t= lxb_selectors_nested ;

// pub const lexbor_callback_f = ?*const fn (buffer: ?*lxb_char_t, size: usize, ctx: ?*anyopaque) callconv(.C) lxb_status_t;

pub const  lxb_selectors_cb_f =  ?*const fn(node:?*lxb_dom_node_t , spec: lxb_css_selector_specificity_t , ctx: ?*anyopaque) lxb_status_t;

pub const  lxb_selectors_state_cb_f  = ?*const fn (selectors:?*lxb_selectors_t, entry:?*lxb_selectors_entry_t )?*lxb_selectors_entry_t ;

pub const  lxb_selectors_entry = extern struct{
    id:usize                     ,
    combinator:lxb_css_selector_combinator_t ,
    selector:?*const lxb_css_selector_t,
    node:?*lxb_dom_node_t                ,
    next:?*lxb_selectors_entry_t         ,
    prev:?*lxb_selectors_entry_t         ,
    following:?*lxb_selectors_entry_t         ,
    nested:?*lxb_selectors_nested_t        ,
};

pub const  lxb_selectors_nested =extern struct{
    entry:?*lxb_selectors_entry_t    ,
    return_state:lxb_selectors_state_cb_f ,
    cb:lxb_selectors_cb_f       ,
    ctx:?*anyopaque,
    root:?*lxb_dom_node_t           ,
    last:?*lxb_selectors_entry_t    ,
    parent:?*lxb_selectors_nested_t   ,
    index:usize,
    found:bool                     ,
};

pub const  lxb_selectors =extern struct{
    state:lxb_selectors_state_cb_f ,
    objs:?*lexbor_dobject_t         ,
    nested:?*lexbor_dobject_t         ,
    current:?*lxb_selectors_nested_t   ,
    first:?*lxb_selectors_entry_t    ,
    options:lxb_selectors_opt_t      ,
    status:lxb_status_t             ,
};
