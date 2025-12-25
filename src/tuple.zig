const std = @import("std");
const testing = std.testing;

pub const Tuple = struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
    

    const Self = @This();
    pub inline fn p(x: f32, y: f32, z: f32) Self {
        return .{ .x = x, .y = y, .z = z, .w = 0.0 };
    }

    pub inline fn v(x: f32, y: f32, z: f32) Self {
        return .{ .x = x, .y = y, .z = z, .w = 1.0 };
    }

    pub inline fn isP(self: Self) bool {
        return self.w == 0.0;
    }

    pub inline fn isV(self: Self) bool {
        return self.w == 1.0;
    }
};

test "Tuple" {
    const a1 = Tuple.p(4.3, -4.2, 3.1);
    const a2 = Tuple.v(4.3, -4.2, 3.1);

    try testing.expect(a1.isP());
    try testing.expect(!a1.isV());

    try testing.expect(a1.x == 4.3);
    try testing.expect(a1.y == -4.2);
    try testing.expect(a1.z ==  3.1);
    try testing.expect(a1.w == 0.0);

    try testing.expect(!a2.isP());
    try testing.expect(a2.isV());

    try testing.expect(a2.x == 4.3);
    try testing.expect(a2.y == -4.2);
    try testing.expect(a2.z == 3.1);
    try testing.expect(a2.w == 1.0);
}

