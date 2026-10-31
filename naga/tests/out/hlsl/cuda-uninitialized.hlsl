struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
cbuffer n : register(b2) { type_5 n; }

int select_value(int value_1, bool choose_first)
{
    int result = (int)0;

    if (choose_first) {
        result = asint(asuint(value_1) + asuint(int(3)));
    } else {
        result = asint(asuint(value_1) - asuint(int(2)));
    }
    int _e9 = result;
    return _e9;
}

float scaled(float value_2)
{
    float result_1 = ((value_2 * 2.0) + 4.0);
    return result_1;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint accumulate(uint limit)
{
    uint sum = (uint)0;
    uint i = (uint)0;
    uint term = (uint)0;

    sum = 0u;
    {
        i = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e24 = i;
                i = (_e24 + uint(int(1)));
            }
            loop_init = false;
            uint _e5 = i;
            if ((_e5 < limit)) {
            } else {
                break;
            }
            uint _e7 = i;
            if ((naga_mod(_e7, 2u) == 0u)) {
                uint _e12 = i;
                term = (_e12 + 1u);
            } else {
                uint _e16 = i;
                term = (_e16 * 2u);
            }
            uint _e21 = term;
            uint _e22 = sum;
            sum = (_e22 + _e21);
        }
    }
    uint _e28 = sum;
    return _e28;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void uninitialized(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    uint base = (uint)0;
    int value = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    int chosen = (int)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    float weighted = (float)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    bool negative = (bool)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint magnitude = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int copied = (int)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    int descending = (int)0;
    int iteration_1 = (int)0;
    int staged = (int)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    int remaining = (int)0;
    int partial = (int)0;
    int next = (int)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    int shadow = (int)0;
    int shadow_1 = (int)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    int local_26 = (int)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    int local_30 = (int)0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34[2] = (uint[2])0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55[2] = (uint[2])0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58[2] = (uint[2])0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61[2] = (uint[2])0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64[2] = (uint[2])0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 1u;
    input[1] = 0u;
    uint n_1 = n.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 12u);
        uint _e27[2] = input;
        local = _e27;
        local_1 = uint(i_1);
        uint _e31[2] = local;
        local_27 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_27[1];
        local_27[1] = (_e35 + _e33);
        uint _e39 = local_27[0];
        local_28 = uint(_e39);
        uint _e43 = local_27[1];
        local_29 = uint(_e43);
        uint _e46 = local_29;
        int _e49 = asint(input_1.Load(_e46*4));
        local_30 = _e49;
        int _e51 = local_30;
        local_26 = _e51;
        int _e53 = local_26;
        value = _e53;
        if ((naga_mod(i_1, 2u) == 0u)) {
            int _e59 = value;
            chosen = asint(asuint(_e59) + asuint(int(7)));
        } else {
            int _e63 = value;
            chosen = asint(asuint(_e63) - asuint(int(4)));
        }
        int _e68 = chosen;
        uint _e70[2] = out_;
        local_2 = _e70;
        uint _e72 = base;
        local_3 = uint(_e72);
        uint _e75[2] = local_2;
        local_31 = _e75;
        uint _e77 = local_3;
        uint _e79 = local_31[1];
        local_31[1] = (_e79 + _e77);
        uint _e83 = local_31[0];
        local_32 = uint(_e83);
        uint _e87 = local_31[1];
        local_33 = uint(_e87);
        uint _e90 = local_33;
        out_1.Store(_e90*4, asuint(_e68));
        int _e93 = value;
        const int _e98 = select_value(_e93, (naga_mod(i_1, 3u) == 0u));
        uint _e99[2] = out_;
        local_4 = _e99;
        uint _e101 = base;
        local_5 = uint((_e101 + 1u));
        uint _e106[2] = local_4;
        local_34 = _e106;
        uint _e108 = local_5;
        uint _e110 = local_34[1];
        local_34[1] = (_e110 + _e108);
        uint _e114 = local_34[0];
        local_35 = uint(_e114);
        uint _e118 = local_34[1];
        local_36 = uint(_e118);
        uint _e121 = local_36;
        out_1.Store(_e121*4, asuint(_e98));
        int _e123 = value;
        weighted = ((float(_e123) * 1.5) + 2.0);
        float _e130 = weighted;
        uint _e132[2] = out_;
        local_6 = _e132;
        uint _e134 = base;
        local_7 = uint((_e134 + 2u));
        uint _e139[2] = local_6;
        local_37 = _e139;
        uint _e141 = local_7;
        uint _e143 = local_37[1];
        local_37[1] = (_e143 + _e141);
        uint _e147 = local_37[0];
        local_38 = uint(_e147);
        uint _e151 = local_37[1];
        local_39 = uint(_e151);
        uint _e154 = local_39;
        out_1.Store(_e154*4, asuint(naga_f2i32(_e130)));
        int _e156 = value;
        negative = (_e156 < int(0));
        bool _e160 = negative;
        uint _e161[2] = out_;
        local_8 = _e161;
        uint _e163 = base;
        local_9 = uint((_e163 + 3u));
        uint _e169[2] = local_8;
        local_40 = _e169;
        uint _e171 = local_9;
        uint _e173 = local_40[1];
        local_40[1] = (_e173 + _e171);
        uint _e177 = local_40[0];
        local_41 = uint(_e177);
        uint _e181 = local_40[1];
        local_42 = uint(_e181);
        uint _e184 = local_42;
        out_1.Store(_e184*4, asuint(int(_e160)));
        int _e186 = value;
        magnitude = uint(asint(asuint(_e186) + asuint(int(5))));
        uint _e191 = magnitude;
        uint _e194[2] = out_;
        local_10 = _e194;
        uint _e196 = base;
        local_11 = uint((_e196 + 4u));
        uint _e202[2] = local_10;
        local_43 = _e202;
        uint _e204 = local_11;
        uint _e206 = local_43[1];
        local_43[1] = (_e206 + _e204);
        uint _e210 = local_43[0];
        local_44 = uint(_e210);
        uint _e214 = local_43[1];
        local_45 = uint(_e214);
        uint _e217 = local_45;
        out_1.Store(_e217*4, asuint(int((_e191 * 3u))));
        const uint _e221 = accumulate(naga_mod(i_1, 5u));
        uint _e222[2] = out_;
        local_12 = _e222;
        uint _e224 = base;
        local_13 = uint((_e224 + 5u));
        uint _e230[2] = local_12;
        local_46 = _e230;
        uint _e232 = local_13;
        uint _e234 = local_46[1];
        local_46[1] = (_e234 + _e232);
        uint _e238 = local_46[0];
        local_47 = uint(_e238);
        uint _e242 = local_46[1];
        local_48 = uint(_e242);
        uint _e245 = local_48;
        out_1.Store(_e245*4, asuint(int(_e221)));
        total = int(0);
        {
            iteration = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e261 = iteration;
                    iteration = asint(asuint(_e261) + asuint(int(1)));
                }
                loop_init_1 = false;
                int _e251 = iteration;
                if ((_e251 < int(3))) {
                } else {
                    break;
                }
                int _e254 = value;
                int _e255 = iteration;
                copied = asint(asuint(_e254) + asuint(_e255));
                int _e258 = copied;
                int _e259 = total;
                total = asint(asuint(_e259) + asuint(_e258));
            }
        }
        int _e264 = total;
        uint _e265[2] = out_;
        local_14 = _e265;
        uint _e267 = base;
        local_15 = uint((_e267 + 6u));
        uint _e272[2] = local_14;
        local_49 = _e272;
        uint _e274 = local_15;
        uint _e276 = local_49[1];
        local_49[1] = (_e276 + _e274);
        uint _e280 = local_49[0];
        local_50 = uint(_e280);
        uint _e284 = local_49[1];
        local_51 = uint(_e284);
        uint _e287 = local_51;
        out_1.Store(_e287*4, asuint(_e264));
        descending = int(0);
        iteration_1 = int(0);
        {
            uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e303 = iteration_1;
                    iteration_1 = asint(asuint(_e303) + asuint(int(1)));
                }
                loop_init_2 = false;
                int _e293 = iteration_1;
                if ((_e293 < int(3))) {
                } else {
                    break;
                }
                int _e296 = value;
                int _e297 = iteration_1;
                staged = asint(asuint(_e296) - asuint(_e297));
                int _e300 = staged;
                int _e301 = descending;
                descending = asint(asuint(_e301) + asuint(_e300));
            }
        }
        int _e306 = descending;
        uint _e307[2] = out_;
        local_16 = _e307;
        uint _e309 = base;
        local_17 = uint((_e309 + 7u));
        uint _e314[2] = local_16;
        local_52 = _e314;
        uint _e316 = local_17;
        uint _e318 = local_52[1];
        local_52[1] = (_e318 + _e316);
        uint _e322 = local_52[0];
        local_53 = uint(_e322);
        uint _e326 = local_52[1];
        local_54 = uint(_e326);
        uint _e329 = local_54;
        out_1.Store(_e329*4, asuint(_e306));
        remaining = int(2);
        int _e333 = value;
        partial = _e333;
        uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
        while(true) {
            if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e335 = remaining;
            if ((_e335 > int(0))) {
            } else {
                break;
            }
            {
                int _e338 = partial;
                int _e339 = remaining;
                next = asint(asuint(_e338) + asuint(_e339));
                int _e342 = next;
                partial = _e342;
                int _e343 = remaining;
                remaining = asint(asuint(_e343) - asuint(int(1)));
            }
        }
        int _e346 = partial;
        uint _e347[2] = out_;
        local_18 = _e347;
        uint _e349 = base;
        local_19 = uint((_e349 + 8u));
        uint _e354[2] = local_18;
        local_55 = _e354;
        uint _e356 = local_19;
        uint _e358 = local_55[1];
        local_55[1] = (_e358 + _e356);
        uint _e362 = local_55[0];
        local_56 = uint(_e362);
        uint _e366 = local_55[1];
        local_57 = uint(_e366);
        uint _e369 = local_57;
        out_1.Store(_e369*4, asuint(_e346));
        int _e371 = value;
        shadow = _e371;
        {
            int _e373 = value;
            shadow_1 = asint(asuint(_e373) + asuint(int(10)));
            int _e377 = shadow_1;
            uint _e378[2] = out_;
            local_20 = _e378;
            uint _e380 = base;
            local_21 = uint((_e380 + 9u));
            uint _e385[2] = local_20;
            local_58 = _e385;
            uint _e387 = local_21;
            uint _e389 = local_58[1];
            local_58[1] = (_e389 + _e387);
            uint _e393 = local_58[0];
            local_59 = uint(_e393);
            uint _e397 = local_58[1];
            local_60 = uint(_e397);
            uint _e400 = local_60;
            out_1.Store(_e400*4, asuint(_e377));
        }
        int _e402 = shadow;
        uint _e403[2] = out_;
        local_22 = _e403;
        uint _e405 = base;
        local_23 = uint((_e405 + 10u));
        uint _e410[2] = local_22;
        local_61 = _e410;
        uint _e412 = local_23;
        uint _e414 = local_61[1];
        local_61[1] = (_e414 + _e412);
        uint _e418 = local_61[0];
        local_62 = uint(_e418);
        uint _e422 = local_61[1];
        local_63 = uint(_e422);
        uint _e425 = local_63;
        out_1.Store(_e425*4, asuint(_e402));
        int _e427 = value;
        const float _e429 = scaled(float(_e427));
        uint _e430[2] = out_;
        local_24 = _e430;
        uint _e432 = base;
        local_25 = uint((_e432 + 11u));
        uint _e438[2] = local_24;
        local_64 = _e438;
        uint _e440 = local_25;
        uint _e442 = local_64[1];
        local_64[1] = (_e442 + _e440);
        uint _e446 = local_64[0];
        local_65 = uint(_e446);
        uint _e450 = local_64[1];
        local_66 = uint(_e450);
        uint _e453 = local_66;
        out_1.Store(_e453*4, asuint(naga_f2i32(_e429)));
    }
}
