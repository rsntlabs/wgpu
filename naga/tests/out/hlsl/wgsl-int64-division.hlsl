struct Values {
    int64_t signed_scalar;
    uint64_t unsigned_scalar;
    int64_t2 signed_pair;
    uint64_t2 unsigned_pair;
    int _pad4_0;
    int _pad4_1;
    int _pad4_2;
    int _pad4_3;
    int64_t3 signed_triple;
    int _pad5_0;
    int _pad5_1;
    uint64_t3 unsigned_triple;
    int _pad6_0;
    int _pad6_1;
    int64_t4 signed_quad;
    uint64_t4 unsigned_quad;
};

ByteAddressBuffer operands : register(t0);
RWByteAddressBuffer quotients : register(u1);
RWByteAddressBuffer remainders : register(u2);

int64_t naga_div(int64_t lhs, int64_t rhs) {
    return lhs / (((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

uint64_t naga_div(uint64_t lhs, uint64_t rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

int64_t2 naga_div(int64_t2 lhs, int64_t2 rhs) {
    return lhs / (((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

uint64_t2 naga_div(uint64_t2 lhs, uint64_t2 rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

int64_t3 naga_div(int64_t3 lhs, int64_t3 rhs) {
    return lhs / (((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

uint64_t3 naga_div(uint64_t3 lhs, uint64_t3 rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

int64_t4 naga_div(int64_t4 lhs, int64_t4 rhs) {
    return lhs / (((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

uint64_t4 naga_div(uint64_t4 lhs, uint64_t4 rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

int64_t naga_mod(int64_t lhs, int64_t rhs) {
    int64_t divisor = ((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

uint64_t naga_mod(uint64_t lhs, uint64_t rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

int64_t2 naga_mod(int64_t2 lhs, int64_t2 rhs) {
    int64_t2 divisor = ((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

uint64_t2 naga_mod(uint64_t2 lhs, uint64_t2 rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

int64_t3 naga_mod(int64_t3 lhs, int64_t3 rhs) {
    int64_t3 divisor = ((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

uint64_t3 naga_mod(uint64_t3 lhs, uint64_t3 rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

int64_t4 naga_mod(int64_t4 lhs, int64_t4 rhs) {
    int64_t4 divisor = ((lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

uint64_t4 naga_mod(uint64_t4 lhs, uint64_t4 rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

Values ConstructValues(int64_t arg0, uint64_t arg1, int64_t2 arg2, uint64_t2 arg3, int64_t3 arg4, uint64_t3 arg5, int64_t4 arg6, uint64_t4 arg7) {
    Values ret = (Values)0;
    ret.signed_scalar = arg0;
    ret.unsigned_scalar = arg1;
    ret.signed_pair = arg2;
    ret.unsigned_pair = arg3;
    ret.signed_triple = arg4;
    ret.unsigned_triple = arg5;
    ret.signed_quad = arg6;
    ret.unsigned_quad = arg7;
    return ret;
}

[numthreads(1, 1, 1)]
void integer_division()
{
    Values dividend = ConstructValues(operands.Load<int64_t>(0+0), operands.Load<uint64_t>(0+8), operands.Load<int64_t2>(0+16), operands.Load<uint64_t2>(0+32), operands.Load<int64_t3>(0+64), operands.Load<uint64_t3>(0+96), operands.Load<int64_t4>(0+128), operands.Load<uint64_t4>(0+160));
    Values divisor = ConstructValues(operands.Load<int64_t>(192+0), operands.Load<uint64_t>(192+8), operands.Load<int64_t2>(192+16), operands.Load<uint64_t2>(192+32), operands.Load<int64_t3>(192+64), operands.Load<uint64_t3>(192+96), operands.Load<int64_t4>(192+128), operands.Load<uint64_t4>(192+160));
    {
        Values _value2 = ConstructValues(naga_div(dividend.signed_scalar, divisor.signed_scalar), naga_div(dividend.unsigned_scalar, divisor.unsigned_scalar), naga_div(dividend.signed_pair, divisor.signed_pair), naga_div(dividend.unsigned_pair, divisor.unsigned_pair), naga_div(dividend.signed_triple, divisor.signed_triple), naga_div(dividend.unsigned_triple, divisor.unsigned_triple), naga_div(dividend.signed_quad, divisor.signed_quad), naga_div(dividend.unsigned_quad, divisor.unsigned_quad));
        quotients.Store(0+0, _value2.signed_scalar);
        quotients.Store(0+8, _value2.unsigned_scalar);
        quotients.Store(0+16, _value2.signed_pair);
        quotients.Store(0+32, _value2.unsigned_pair);
        quotients.Store(0+64, _value2.signed_triple);
        quotients.Store(0+96, _value2.unsigned_triple);
        quotients.Store(0+128, _value2.signed_quad);
        quotients.Store(0+160, _value2.unsigned_quad);
    }
    {
        Values _value2 = ConstructValues(naga_mod(dividend.signed_scalar, divisor.signed_scalar), naga_mod(dividend.unsigned_scalar, divisor.unsigned_scalar), naga_mod(dividend.signed_pair, divisor.signed_pair), naga_mod(dividend.unsigned_pair, divisor.unsigned_pair), naga_mod(dividend.signed_triple, divisor.signed_triple), naga_mod(dividend.unsigned_triple, divisor.unsigned_triple), naga_mod(dividend.signed_quad, divisor.signed_quad), naga_mod(dividend.unsigned_quad, divisor.unsigned_quad));
        remainders.Store(0+0, _value2.signed_scalar);
        remainders.Store(0+8, _value2.unsigned_scalar);
        remainders.Store(0+16, _value2.signed_pair);
        remainders.Store(0+32, _value2.unsigned_pair);
        remainders.Store(0+64, _value2.signed_triple);
        remainders.Store(0+96, _value2.unsigned_triple);
        remainders.Store(0+128, _value2.signed_quad);
        remainders.Store(0+160, _value2.unsigned_quad);
    }
    return;
}
