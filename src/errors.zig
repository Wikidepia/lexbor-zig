pub const core = @import("core_ext.zig");

pub const LxbStatusError = error{
    Error,
    MemoryAllocation,
    ObjectIsNull,
    SmallBuffer,
    IncompleteObject,
    NoFreeSlot,
    TooSmallSize,
    NotExists,
    WrongArgs,
    WrongStage,
    UnexpectedResult,
    UnexpectedData,
    Overflow,
};

pub fn maybeLxbStatusError(status: core.lxb_status_t) LxbStatusError!void {
    return switch (@as(core.lexbor_status_t, @enumFromInt(status))) {
        .@"error" => error.Error,
        .error_memory_allocation => error.MemoryAllocation,
        .error_object_is_null => error.ObjectIsNull,
        .error_small_buffer => error.SmallBuffer,
        .error_incomplete_object => error.IncompleteObject,
        .error_no_free_slot => error.NoFreeSlot,
        .error_too_small_size => error.TooSmallSize,
        .error_not_exists => error.NotExists,
        .error_wrong_args => error.WrongArgs,
        .error_wrong_stage => error.WrongStage,
        .error_unexpected_result => error.UnexpectedResult,
        .error_unexpected_data => error.UnexpectedData,
        .error_overflow => error.Overflow,
        else => {},
    };
}
