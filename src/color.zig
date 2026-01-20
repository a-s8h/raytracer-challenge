const std = @import("std");

const eps = 0.000001;

pub const Color = struct {
    r: f32,
    g: f32,
    b: f32,

    const Self = @This();
    pub inline fn n(r: f32, g: f32, b: f32) Self {
        return .{ .r = r, .g = g, .b = b };
    }

    pub inline fn add(self: Self, other: Self) Self {
        return .{ .r = self.r + other.r, .g = self.g + other.g, .b = self.b + other.b };
    }

    pub inline fn sub(self: Self, other: Self) Self {
        return .{ .r = self.r - other.r, .g = self.g - other.g, .b = self.b - other.b };
    }

    pub inline fn mulS(self: Self, m: f32) Self {
        return .{ .r = self.r * m, .g = self.g * m, .b = self.b * m };
    }

    pub inline fn mulC(self: Self, other: Self) Self {
        return .{ .r = self.r * other.r, .g = self.g * other.g, .b = self.b * other.b };
    }

    pub inline fn eql(self: Self, other: Self) bool {
        return @abs(self.r - other.r) < eps and
            @abs(self.g - other.g) < eps and
            @abs(self.b - other.b) < eps; 
    }
};


test "Create color" {
    const c = Color.n(-0.5, 0.4, 1.7);

    try std.testing.expect(c.r == -0.5);
    try std.testing.expect(c.g == 0.4);
    try std.testing.expect(c.b == 1.7);
}

test "Color operations" {
    const c1 = Color.n(0.9, 0.6, 0.75);
    const c2 = Color.n(0.7, 0.1, 0.25);

    try std.testing.expect(c1.add(c2).eql(Color.n(1.6, 0.7, 1.0)));
    try std.testing.expect(c1.sub(c2).eql(Color.n(0.2, 0.5, 0.5)));

    const c = Color.n(0.2, 0.3, 0.4);
    try std.testing.expect(c.mulS(2).eql(Color.n(0.4, 0.6, 0.8)));

    const c3 = Color.n(1, 0.2, 0.4);
    const c4 = Color.n(0.9, 1, 0.1);
    try std.testing.expect(c3.mulC(c4).eql(Color.n(0.9, 0.2, 0.04)));
}

