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
        .LXB_STATUS_ERROR => error.Error,
        .LXB_STATUS_ERROR_MEMORY_ALLOCATION => error.MemoryAllocation,
        .LXB_STATUS_ERROR_OBJECT_IS_NULL => error.ObjectIsNull,
        .LXB_STATUS_ERROR_SMALL_BUFFER => error.SmallBuffer,
        .LXB_STATUS_ERROR_INCOMPLETE_OBJECT => error.IncompleteObject,
        .LXB_STATUS_ERROR_NO_FREE_SLOT => error.NoFreeSlot,
        .LXB_STATUS_ERROR_TOO_SMALL_SIZE => error.TooSmallSize,
        .LXB_STATUS_ERROR_NOT_EXISTS => error.NotExists,
        .LXB_STATUS_ERROR_WRONG_ARGS => error.WrongArgs,
        .LXB_STATUS_ERROR_WRONG_STAGE => error.WrongStage,
        .LXB_STATUS_ERROR_UNEXPECTED_RESULT => error.UnexpectedResult,
        .LXB_STATUS_ERROR_UNEXPECTED_DATA => error.UnexpectedData,
        .LXB_STATUS_ERROR_OVERFLOW => error.Overflow,
        else => {},
    };
}
