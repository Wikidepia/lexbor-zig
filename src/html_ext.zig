// const std = @import("std");
const lexbor_str_t  = @import("./core_ext.zig").lexbor_str_t;
const lxb_status_t = @import("./core_ext.zig").lxb_status_t;
const lexbor_avl_t = @import("./core_ext.zig").lexbor_avl_t;
const lexbor_array_t = @import("./core_ext.zig").lexbor_array_t;
const lexbor_hash_t = @import("./core_ext.zig").lexbor_hash_t;
const lexbor_dobject_t = @import("./core_ext.zig").lexbor_dobject_t;
const lxb_css_memory_t = @import("./css_ext.zig").lxb_css_memory_t;
const lxb_css_selectors_t = @import("./css_ext.zig").lxb_css_selectors_t;
const lxb_css_parser_t = @import("./css_ext.zig").lxb_css_parser_t;
const lxb_css_rule_declaration_t = @import("./css_ext.zig").lxb_css_rule_declaration_t;
const lxb_css_selector_specificity_t= @import("./css_ext.zig").lxb_css_selector_specificity_t;
const lxb_css_stylesheet_t= @import("./css_ext.zig").xb_css_stylesheet_t;
const lxb_selectors_t = @import("./selectors_ext.zig").lxb_selectors_t;

// html/interfaces/document.h

pub const lxb_html_document_done_cb_f = ?*const fn (document: ?*lxb_html_document_t) callconv(.C) lxb_status_t;

pub const lxb_html_document_opt_t = c_uint;

pub const lxb_html_document_ready_state_t = enum(c_int) {
    LXB_HTML_DOCUMENT_READY_STATE_UNDEF       = 0x00,
    LXB_HTML_DOCUMENT_READY_STATE_LOADING     = 0x01,
    LXB_HTML_DOCUMENT_READY_STATE_INTERACTIVE = 0x02,
    LXB_HTML_DOCUMENT_READY_STATE_COMPLETE    = 0x03,
};

pub const lxb_html_document_opt = enum(c_int) {
    LXB_HTML_DOCUMENT_OPT_UNDEF     = 0x00,
    LXB_HTML_DOCUMENT_PARSE_WO_COPY = 0x01,
};

pub const lxb_html_document_css_t = extern struct {
    memory: ?*lxb_css_memory_t,
    css_selectors: ?*lxb_css_selectors_t,
    parser: ?*lxb_css_parser_t,
   selectors:?* lxb_selectors_t     ,
   styles:?* lexbor_avl_t        ,
   stylesheets:?*lexbor_array_t      ,
   weak:?*lexbor_dobject_t    ,
   customs:?*lexbor_hash_t       ,
   customs_id : usize,
};

pub const lxb_html_document   = extern struct {
    dom_document: lxb_dom_document_t              ,
    iframe_srcdoc                            :?*anyopaque,
    head:?*lxb_html_head_element_t         ,
    body:?*lxb_html_body_element_t         ,
    css:lxb_html_document_css_t         ,
    css_init:bool                            ,
    done:lxb_html_document_done_cb_f     ,
    ready_state:lxb_html_document_ready_state_t ,
    opt:lxb_html_document_opt_t         ,
};

// html/interface.h

pub const  lxb_html_document_t =  lxb_html_document ;
pub const  lxb_html_anchor_element_t =  lxb_html_anchor_element ;
pub const  lxb_html_area_element_t =  lxb_html_area_element ;
pub const  lxb_html_audio_element_t =  lxb_html_audio_element ;
pub const  lxb_html_br_element_t =  lxb_html_br_element ;
pub const   lxb_html_base_element_t=  lxb_html_base_element ;
pub const   lxb_html_body_element_t=  lxb_html_body_element ;
pub const   lxb_html_button_element_t=  lxb_html_button_element ;
pub const   lxb_html_canvas_element_t=  lxb_html_canvas_element ;
pub const   lxb_html_d_list_element_t=  lxb_html_d_list_element ;
pub const   lxb_html_data_element_t=  lxb_html_data_element ;
pub const  lxb_html_data_list_element_t =  lxb_html_data_list_element ;
pub const   lxb_html_details_element_t=  lxb_html_details_element ;
pub const   lxb_html_dialog_element_t=  lxb_html_dialog_element ;
pub const   lxb_html_directory_element_t=  lxb_html_directory_element ;
pub const   lxb_html_div_element_t=  lxb_html_div_element ;
pub const   lxb_html_element_t=  lxb_html_element ;
pub const   lxb_html_embed_element_t=  lxb_html_embed_element ;
pub const   lxb_html_field_set_element_t=  lxb_html_field_set_element ;
pub const   lxb_html_font_element_t=  lxb_html_font_element ;
pub const   lxb_html_form_element_t=  lxb_html_form_element ;
pub const   lxb_html_frame_element_t=  lxb_html_frame_element ;
pub const   lxb_html_frame_set_element_t=  lxb_html_frame_set_element ;
pub const   lxb_html_hr_element_t=  lxb_html_hr_element ;
pub const   lxb_html_head_element_t=  lxb_html_head_element ;
pub const   lxb_html_heading_element_t=  lxb_html_heading_element ;
pub const   lxb_html_html_element_t=  lxb_html_html_element ;
pub const   lxb_html_iframe_element_t=  lxb_html_iframe_element ;
pub const   lxb_html_image_element_t=  lxb_html_image_element ;
pub const   lxb_html_input_element_t=  lxb_html_input_element ;
pub const   lxb_html_li_element_t=  lxb_html_li_element ;
pub const   lxb_html_label_element_t=  lxb_html_label_element ;
pub const   lxb_html_legend_element_t=  lxb_html_legend_element ;
pub const   lxb_html_link_element_t=  lxb_html_link_element ;
pub const   lxb_html_map_element_t=  lxb_html_map_element ;
pub const   lxb_html_marquee_element_t=  lxb_html_marquee_element ;
pub const   lxb_html_media_element_t=  lxb_html_media_element ;
pub const   lxb_html_menu_element_t=  lxb_html_menu_element ;
pub const   lxb_html_meta_element_t=  lxb_html_meta_element ;
pub const   lxb_html_meter_element_t=  lxb_html_meter_element ;
pub const   lxb_html_mod_element_t=  lxb_html_mod_element ;
pub const   lxb_html_o_list_element_t=  lxb_html_o_list_element ;
pub const   lxb_html_object_element_t=  lxb_html_object_element ;
pub const   lxb_html_opt_group_element_t=  lxb_html_opt_group_element ;
pub const   lxb_html_option_element_t=  lxb_html_option_element ;
pub const   lxb_html_output_element_t=  lxb_html_output_element ;
pub const   lxb_html_paragraph_element_t=  lxb_html_paragraph_element ;
pub const   lxb_html_param_element_t=  lxb_html_param_element ;
pub const   lxb_html_picture_element_t=  lxb_html_picture_element ;
pub const   lxb_html_pre_element_t=  lxb_html_pre_element ;
pub const   lxb_html_progress_element_t=  lxb_html_progress_element ;
pub const   lxb_html_quote_element_t=  lxb_html_quote_element ;
pub const   lxb_html_script_element_t=  lxb_html_script_element ;
pub const   lxb_html_select_element_t=  lxb_html_select_element ;
pub const   lxb_html_slot_element_t=  lxb_html_slot_element ;
pub const   lxb_html_source_element_t=  lxb_html_source_element ;
pub const   lxb_html_span_element_t=  lxb_html_span_element ;
pub const   lxb_html_style_element_t=  lxb_html_style_element ;
pub const   lxb_html_table_caption_element_t=  lxb_html_table_caption_element ;
pub const   lxb_html_table_cell_element_t=  lxb_html_table_cell_element ;
pub const   lxb_html_table_col_element_t=  lxb_html_table_col_element ;
pub const   lxb_html_table_element_t=  lxb_html_table_element ;
pub const   lxb_html_table_row_element_t=  lxb_html_table_row_element ;
pub const   lxb_html_table_section_element_t=  lxb_html_table_section_element ;
pub const   lxb_html_template_element_t=  lxb_html_template_element ;
pub const   lxb_html_text_area_element_t=  lxb_html_text_area_element ;
pub const   lxb_html_time_element_t=  lxb_html_time_element ;
pub const   lxb_html_title_element_t=  lxb_html_title_element ;
pub const   lxb_html_track_element_t=  lxb_html_track_element ;
pub const   lxb_html_u_list_element_t=  lxb_html_u_list_element ;
pub const   lxb_html_unknown_element_t=  lxb_html_unknown_element ;
pub const   lxb_html_video_element_t=  lxb_html_video_element ;
pub const   lxb_html_window_t=  lxb_html_window ;

// html/interfaces/anchor_element.h

pub const lxb_html_anchor_element  = extern struct {
    element:lxb_html_element_t ,
};

// html/interfaces/area_element.h

pub const lxb_html_area_element  = extern struct {
    element:lxb_html_element_t ,
};

// html/interfaces/audio_element.h

pub const lxb_html_audio_element  = extern struct {
    media_element:lxb_html_media_element_t ,
};

// html/interfaces/base_element.h

pub const lxb_html_base_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/body_element.h

pub const lxb_html_body_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/br_element.h

pub const lxb_html_br_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/button_element.h

pub const lxb_html_button_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/canvas_element.h

pub const lxb_html_canvas_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/d_list_element.h

pub const lxb_html_d_list_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/data_element.h

pub const lxb_html_data_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/data_list_element.h

pub const lxb_html_data_list_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/details_element.h

pub const lxb_html_details_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/dialog_element.h

pub const lxb_html_dialog_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/directory_element.h

pub const lxb_html_directory_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/div_element.h

pub const lxb_html_div_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/element.h

pub const  lxb_html_element  = extern struct {
    element:lxb_dom_element_t               ,
   style:?* lexbor_avl_node_t               ,
   list:?* lxb_css_rule_declaration_list_t ,
};

pub const lxb_html_element_style_opt_t =  enum (c_int){
    LXB_HTML_ELEMENT_OPT_UNDEF = 0x00,
} ;

pub const lxb_html_element_style_cb_f = ?*const fn(element:?*lxb_html_element_t , declr: ?*const lxb_css_rule_declaration_t , ctx: ?*anyopaque, spec: lxb_css_selector_specificity_t , is_weak: bool ) lxb_status_t;

// html/interfaces/embed_element.h

pub const lxb_html_embed_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/field_set_element.h

pub const lxb_html_field_set_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/font_element.h

pub const lxb_html_font_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/form_element.h

pub const lxb_html_form_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/frame_element.h

pub const lxb_html_frame_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/frame_set_element.h

pub const lxb_html_frame_set_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/head_element.h

pub const lxb_html_head_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/heading_element.h

pub const lxb_html_heading_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/hr_element.h

pub const lxb_html_hr_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/html_element.h

pub const lxb_html_html_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/iframe_element.h

pub const lxb_html_iframe_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/image_element.h

pub const lxb_html_image_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/input_element.h

pub const lxb_html_input_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/label_element.h

pub const lxb_html_label_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/legend_element.h

pub const lxb_html_legend_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/li_element.h

pub const lxb_html_li_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/link_element.h

pub const lxb_html_link_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/map_element.h

pub const lxb_html_map_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/marquee_element.h

pub const lxb_html_marquee_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/media_element.h

pub const lxb_html_media_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/menu_element.h

pub const lxb_html_menu_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/meta_element.h

pub const lxb_html_meta_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/meter_element.h

pub const lxb_html_meter_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/mod_element.h

pub const lxb_html_mod_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/o_list_element.h

pub const lxb_html_o_list_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/object_element.h

pub const lxb_html_object_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/opt_group_element.h

pub const lxb_html_opt_group_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/option_element.h

pub const lxb_html_option_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/output_element.h

pub const lxb_html_output_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/paragraph_element.h

pub const lxb_html_paragraph_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/param_element.h

pub const lxb_html_param_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/picture_element.h

pub const lxb_html_picture_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/pre_element.h

pub const lxb_html_pre_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/progress_element.h

pub const lxb_html_progress_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/quote_element.h

pub const lxb_html_quote_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/script_element.h

pub const lxb_html_script_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/select_element.h

pub const lxb_html_select_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/slot_element.h

pub const lxb_html_slot_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/source_element.h

pub const lxb_html_source_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/span_element.h

pub const lxb_html_span_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/style_element.h

pub const lxb_html_style_element  = extern struct {
    element: lxb_html_element_t ,
    stylesheet: ?*lxb_css_stylesheet_t ,
};

// html/interfaces/table_caption_element.h

pub const lxb_html_table_caption_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/table_cell_element.h

pub const lxb_html_table_cell_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/table_col_element.h

pub const lxb_html_table_col_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/table_element.h

pub const lxb_html_table_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/table_row_element.h

pub const lxb_html_table_row_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/table_section_element.h

pub const lxb_html_table_section_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/template_element.h

pub const lxb_html_template_element  = extern struct {
    element: lxb_html_element_t ,
    content: ?*lxb_dom_document_fragment_t ,
};

// html/interfaces/text_area_element.h

pub const lxb_html_text_area_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/time_element.h

pub const lxb_html_time_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/title_element.h

pub const lxb_html_title_element  = extern struct {
    element: lxb_html_element_t ,
    strict_text:?*lexbor_str_t,
};

// html/interfaces/track_element.h

pub const lxb_html_track_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/u_list_element.h

pub const lxb_html_u_list_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/unknown_element.h

pub const lxb_html_unknown_element  = extern struct {
    element: lxb_html_element_t ,
};

// html/interfaces/video_element.h

pub const lxb_html_video_element  = extern struct {
    media_element: lxb_html_media_element_t ,
};

// html/interfaces/window.h

pub const lxb_html_window = extern struct {
    event_target: lxb_dom_event_target_t ,
};


