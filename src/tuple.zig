const std = @import("std");
const testing = std.testing;

pub const Tuple = struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,

    const Self = @This();
    pub inline fn p(x: f32, y: f32, z: f32) Self {
        return .{ .x = x, .y = y, .z = z, .w = 1.0 };
    }

    pub inline fn v(x: f32, y: f32, z: f32) Self {
        return .{ .x = x, .y = y, .z = z, .w = 0.0 };
    }

    pub inline fn isP(self: Self) bool {
        return self.w == 1.0;
    }

    pub inline fn isV(self: Self) bool {
        return self.w == 0.0;
    }

    pub inline fn add(self: Self, other: Tuple) Self {
        return .{ .x = self.x + other.x, .y = self.y + other.y, .z = self.z + other.z, .w =  self.w + other.w };
    }

    pub inline fn sub(self: Self, other: Tuple) Self {
        return .{ .x = self.x - other.x, .y = self.y - other.y, .z = self.z - other.z, .w =  self.w - other.w };
    }

    pub inline fn neg(self: Self) Self {
        return .{ .x = -self.x, .y = -self.y, .z = -self.z, .w = -self.w };
    }

    pub inline fn mul(self: Self, s: f32) Self {
        return .{ .x = self.x * s, .y = self.y * s, .z = self.z * s, .w = self.w };
    }

    pub inline fn div(self: Self, d: f32) Self {
        return .{ .x = self.x / d, .y = self.y / d, .z = self.z / d, .w = self.w };
    }

    pub inline fn magnitude(self: Self) f32 {
        return @sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
    }

    pub inline fn normalize(self: Self) Self {
        const norm = self.magnitude();
        return .{ .x = self.x / norm, .y = self.y / norm, .z = self.z / norm, .w = self.w };
    }

    pub inline fn dot(self: Self, other: Tuple) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z + self.w * other.w;
    }

    pub inline fn cross(self: Self, other: Tuple) Self {
        return .{ 
            .x = self.y * other.z - self.z * other.y,
            .y = self.z * other.x - self.x * other.z,
            .z = self.x * other.y - self.y * other.x,
            .w = self.w
        };
    }
};

test "Tuple Creation" {
    const a1 = Tuple.p(4.3, -4.2, 3.1);
    const a2 = Tuple.v(4.3, -4.2, 3.1);

    try testing.expect(std.meta.eql(a1, Tuple.p(4.3, -4.2, 3.1)));
    try testing.expect(a1.isP());
    try testing.expect(!a1.isV());

    try testing.expect(std.meta.eql(a2, Tuple.v(4.3, -4.2, 3.1)));
    try testing.expect(!a2.isP());
    try testing.expect(a2.isV());
}

test "Tuple add and sub" {
    const a1 = Tuple.p(3, -2, 5);
    const a2 = Tuple.v(-2, 3, 1);

    const r = a1.add(a2);
    try testing.expect(std.meta.eql(r, Tuple.p(1, 1, 6)));

    const p1 = Tuple.p(3, 2, 1);
    const p2 = Tuple.p(5, 6, 7);
    const p12 = p1.sub(p2);
    try testing.expect(std.meta.eql(p12, Tuple.v(-2, -4, -6)));

    const v2 = Tuple.v(5, 6, 7);
    const pv = p1.sub(v2);
    try testing.expect(std.meta.eql(pv, Tuple.p(-2, -4, -6)));

    const v1 = Tuple.v(3, 2, 1);
    const v12 = v1.sub(v2);
    try testing.expect(std.meta.eql(v12, Tuple.v(-2, -4, -6)));
}

test "Tupple neg" {
    const v = Tuple.v(1, -2, 3);
    const nv = v.neg();
    try testing.expect(std.meta.eql(nv, Tuple.v(-1, 2, -3)));
}

test "Tuple mul, div" {
    const a = Tuple.v(1, -2, 3);

    const r1 = a.mul(3.5);
    try testing.expect(std.meta.eql(r1, Tuple.v(3.5, -7, 10.5)));

    const r2 = a.mul(0.5);
    try testing.expect(std.meta.eql(r2, Tuple.v(0.5, -1, 1.5)));

    const r3 = a.div(2);
    try testing.expect(std.meta.eql(r3, Tuple.v(0.5, -1, 1.5)));
}

test "Tuple magnitude" {
    const v1 = Tuple.v(1, 0, 0);
    try testing.expect(v1.magnitude() == 1);

    const v2 = Tuple.v(1, 0, 0);
    try testing.expect(v2.magnitude() == 1);
    
    const v3 = Tuple.v(0, 0, 1);
    try testing.expect(v3.magnitude() == 1);

    const v4 = Tuple.v(1, 2, 3);
    try testing.expect(v4.magnitude() == @sqrt(14.0));

    const v5 = Tuple.v(-1, -2, -3);
    try testing.expect(v5.magnitude() == @sqrt(14.0));
}

test "Test normalize" {
    const v1 = Tuple.v(4, 0, 0);
    try testing.expect(std.meta.eql(v1.normalize(), Tuple.v(1, 0, 0)));

    const v2 = Tuple.v(1, 2, 3);
    try testing.expect(std.meta.eql(v2.normalize(), Tuple.v(0.26726124, 0.5345225, 0.8017837)));
    try testing.expect(v2.normalize().magnitude() == 0.99999994);
}

test "Test dot" {
    const a = Tuple.v(1, 2, 3);
    const b = Tuple.v(2, 3, 4);

    try testing.expect(a.dot(b) == 20.0);
}

test "Test cross" {
    const a = Tuple.v(1, 2, 3);
    const b = Tuple.v(2, 3, 4);

    try testing.expect(std.meta.eql(a.cross(b), Tuple.v(-1, 2, -1)));
    try testing.expect(std.meta.eql(b.cross(a), Tuple.v(1, -2, 1)));
}

