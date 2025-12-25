const std = @import("std");
const tuple = @import("tupple");

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}

