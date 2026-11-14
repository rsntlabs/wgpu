// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];
int naga_div(int lhs, int rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
}


struct packed_averagesInput {
};
kernel void packed_averages(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint row = {};
    uint a = {};
    uint local = {};
    uint b = {};
    uint local_1 = {};
    uint base = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint value = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    bool local_19 = {};
    bool local_20 = {};
    uint local_21 = {};
    uint index = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint scale = {};
    uint bias = {};
    uint scale_1 = {};
    uint bias_1 = {};
    uint scale_2 = {};
    uint bias_2 = {};
    uint scale_3 = {};
    uint bias_3 = {};
    uint scale_4 = {};
    uint bias_4 = {};
    uint scale_5 = {};
    uint bias_5 = {};
    uint scale_6 = {};
    uint bias_6 = {};
    uint scale_7 = {};
    uint bias_7 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint lane = threadIdx.x;
    uint count = input[static_cast<uint>(0)];
    {
        row = lane;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e284 = row;
                row = _e284 + 64u;
            }
            loop_init = false;
            uint _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            uint _e10 = row;
            local = static_cast<uint>(1u + (_e10 * 2u));
            uint _e17 = local;
            local_30 = _e17;
            uint _e19 = local_30;
            uint _e21 = input[_e19];
            local_31 = _e21;
            uint _e23 = local_31;
            local_28 = _e23;
            uint _e25 = local_28;
            a = _e25;
            uint _e27 = row;
            local_1 = static_cast<uint>(2u + (_e27 * 2u));
            uint _e34 = local_1;
            local_32 = _e34;
            uint _e36 = local_32;
            uint _e38 = input[_e36];
            local_33 = _e38;
            uint _e40 = local_33;
            local_29 = _e40;
            uint _e42 = local_29;
            b = _e42;
            uint _e44 = row;
            base = 4u + (_e44 * 4u);
            uint _e50 = a;
            uint _e51 = b;
            int _e63 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e50 & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e51 & 65535u) ^ 32768u)) - as_type<uint>(32768))));
            int _e87 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e50 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e51 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))));
            uint _e97 = base;
            local_2 = _e97;
            uint _e99 = local_2;
            local_34 = _e99;
            uint _e101 = local_34;
            output[_e101] = (static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e63) + as_type<uint>((_e63 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e87) + as_type<uint>((_e87 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) << 16u);
            uint _e104 = a;
            uint _e105 = b;
            int _e117 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e104 & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e105 & 255u) ^ 128u)) - as_type<uint>(128))));
            int _e141 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e104 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e105 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))));
            int _e162 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e104 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e105 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))));
            int _e183 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e104 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e105 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))));
            uint _e193 = base;
            local_3 = static_cast<uint>(_e193 + 1u);
            uint _e198 = local_3;
            local_35 = _e198;
            uint _e200 = local_35;
            output[_e200] = (((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e117) + as_type<uint>((_e117 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e141) + as_type<uint>((_e141 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e162) + as_type<uint>((_e162 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e183) + as_type<uint>((_e183 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 24u);
            uint _e202 = a;
            uint _e203 = b;
            uint _e223 = base;
            local_4 = static_cast<uint>(_e223 + 2u);
            uint _e228 = local_4;
            local_36 = _e228;
            uint _e230 = local_36;
            output[_e230] = (((((_e202 & 65535u) + (_e203 & 65535u)) + 1u) >> 1u) & 65535u) | (((((((_e202 >> 16u) & 65535u) + ((_e203 >> 16u) & 65535u)) + 1u) >> 1u) & 65535u) << 16u);
            uint _e232 = a;
            uint _e233 = b;
            uint _e275 = base;
            local_5 = static_cast<uint>(_e275 + 3u);
            uint _e280 = local_5;
            local_37 = _e280;
            uint _e282 = local_37;
            output[_e282] = (((((((_e232 & 255u) + (_e233 & 255u)) + 1u) >> 1u) & 255u) | (((((((_e232 >> 8u) & 255u) + ((_e233 >> 8u) & 255u)) + 1u) >> 1u) & 255u) << 8u)) | (((((((_e232 >> 16u) & 255u) + ((_e233 >> 16u) & 255u)) + 1u) >> 1u) & 255u) << 16u)) | (((((((_e232 >> 24u) & 255u) + ((_e233 >> 24u) & 255u)) + 1u) >> 1u) & 255u) << 24u);
        }
    }
    uint base_1 = (4u + (count * 4u)) + (lane * 12u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e304 = value;
    value = _e304 + static_cast<uint>(1);
    uint _e308 = scale;
    uint _e310 = bias;
    local_6 = (_e304 * _e308) ^ _e310;
    uint _e313 = local_6;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e322 = value;
    value = _e322 + static_cast<uint>(1);
    uint _e326 = scale_1;
    uint _e328 = bias_1;
    local_7 = (_e322 * _e326) ^ _e328;
    uint _e331 = local_7;
    int _e343 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e313 & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e331 & 65535u) ^ 32768u)) - as_type<uint>(32768))));
    int _e367 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e313 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e331 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))));
    output[base_1] = (static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e343) + as_type<uint>((_e343 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e367) + as_type<uint>((_e367 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) << 16u);
    scale_2 = uint {};
    bias_2 = uint {};
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    uint _e387 = value;
    value = _e387 + static_cast<uint>(1);
    uint _e391 = scale_2;
    uint _e393 = bias_2;
    local_9 = (_e387 * _e391) ^ _e393;
    uint _e396 = local_9;
    scale_3 = uint {};
    bias_3 = uint {};
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    uint _e405 = value;
    value = _e405 + static_cast<uint>(1);
    uint _e409 = scale_3;
    uint _e411 = bias_3;
    local_10 = (_e405 * _e409) ^ _e411;
    uint _e414 = local_10;
    int _e426 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e396 & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e414 & 255u) ^ 128u)) - as_type<uint>(128))));
    int _e450 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e396 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e414 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))));
    int _e471 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e396 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e414 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))));
    int _e492 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e396 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e414 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))));
    local_8 = static_cast<uint>(base_1 + 1u);
    uint _e506 = local_8;
    output[_e506] = (((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e426) + as_type<uint>((_e426 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e450) + as_type<uint>((_e450 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e471) + as_type<uint>((_e471 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e492) + as_type<uint>((_e492 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 24u);
    scale_4 = uint {};
    bias_4 = uint {};
    scale_4 = 16909060u;
    bias_4 = 2164195711u;
    uint _e516 = value;
    value = _e516 + static_cast<uint>(1);
    uint _e520 = scale_4;
    uint _e522 = bias_4;
    local_12 = (_e516 * _e520) ^ _e522;
    uint _e525 = local_12;
    scale_5 = uint {};
    bias_5 = uint {};
    scale_5 = 50661129u;
    bias_5 = 4261576960u;
    uint _e534 = value;
    value = _e534 + static_cast<uint>(1);
    uint _e538 = scale_5;
    uint _e540 = bias_5;
    local_13 = (_e534 * _e538) ^ _e540;
    uint _e543 = local_13;
    local_11 = static_cast<uint>(base_1 + 2u);
    uint _e567 = local_11;
    output[_e567] = (((((_e525 & 65535u) + (_e543 & 65535u)) + 1u) >> 1u) & 65535u) | (((((((_e525 >> 16u) & 65535u) + ((_e543 >> 16u) & 65535u)) + 1u) >> 1u) & 65535u) << 16u);
    scale_6 = uint {};
    bias_6 = uint {};
    scale_6 = 16909060u;
    bias_6 = 2164195711u;
    uint _e577 = value;
    value = _e577 + static_cast<uint>(1);
    uint _e581 = scale_6;
    uint _e583 = bias_6;
    local_15 = (_e577 * _e581) ^ _e583;
    uint _e586 = local_15;
    scale_7 = uint {};
    bias_7 = uint {};
    scale_7 = 50661129u;
    bias_7 = 4261576960u;
    uint _e595 = value;
    value = _e595 + static_cast<uint>(1);
    uint _e599 = scale_7;
    uint _e601 = bias_7;
    local_16 = (_e595 * _e599) ^ _e601;
    uint _e604 = local_16;
    local_14 = static_cast<uint>(base_1 + 3u);
    uint _e650 = local_14;
    output[_e650] = (((((((_e586 & 255u) + (_e604 & 255u)) + 1u) >> 1u) & 255u) | (((((((_e586 >> 8u) & 255u) + ((_e604 >> 8u) & 255u)) + 1u) >> 1u) & 255u) << 8u)) | (((((((_e586 >> 16u) & 255u) + ((_e604 >> 16u) & 255u)) + 1u) >> 1u) & 255u) << 16u)) | (((((((_e586 >> 24u) & 255u) + ((_e604 >> 24u) & 255u)) + 1u) >> 1u) & 255u) << 24u);
    if ((lane & 1u) == 0u) {
        uint _e656 = value;
        value = _e656 + static_cast<uint>(1);
        uint _e660 = value;
        value = _e660 + static_cast<uint>(1);
        int _e675 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e656 & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e660 & 65535u) ^ 32768u)) - as_type<uint>(32768))));
        int _e699 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e656 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e660 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))));
        local_17 = (static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e675) + as_type<uint>((_e675 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e699) + as_type<uint>((_e699 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) << 16u);
    } else {
        local_17 = 0u;
    }
    uint _e712 = value;
    local_18 = static_cast<uint>(base_1 + 4u);
    uint _e717 = local_18;
    output[_e717] = _e712;
    local_19 = false;
    if (false) {
        uint _e721 = value;
        value = _e721 + static_cast<uint>(1);
        uint _e725 = value;
        value = _e725 + static_cast<uint>(1);
        local_19 = ((((((_e721 & 65535u) + (_e725 & 65535u)) + 1u) >> 1u) & 65535u) | (((((((_e721 >> 16u) & 65535u) + ((_e725 >> 16u) & 65535u)) + 1u) >> 1u) & 65535u) << 16u)) != 0u;
    }
    local_20 = true;
    if (true) {
    } else {
        uint _e752 = value;
        value = _e752 + static_cast<uint>(1);
        uint _e756 = value;
        value = _e756 + static_cast<uint>(1);
        int _e771 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e752 & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e756 & 255u) ^ 128u)) - as_type<uint>(128))));
        int _e795 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e752 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e756 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))));
        int _e816 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e752 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e756 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))));
        int _e837 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e752 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e756 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))));
        local_20 = ((((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e771) + as_type<uint>((_e771 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e795) + as_type<uint>((_e795 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e816) + as_type<uint>((_e816 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e837) + as_type<uint>((_e837 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 24u)) != 0u;
    }
    uint _e849 = value;
    value = _e849 + static_cast<uint>(1);
    uint _e853 = value;
    value = _e853 + static_cast<uint>(1);
    uint _e857 = value;
    local_21 = static_cast<uint>(base_1 + 5u);
    uint _e862 = local_21;
    output[_e862] = _e857;
    index = 1u;
    uint _e866 = index;
    index = _e866 + static_cast<uint>(1);
    uint _e871 = input[_e866];
    uint _e872 = index;
    index = _e872 + static_cast<uint>(1);
    uint _e877 = input[_e872];
    local_22 = static_cast<uint>(base_1 + 6u);
    uint _e923 = local_22;
    output[_e923] = (((((((_e871 & 255u) + (_e877 & 255u)) + 1u) >> 1u) & 255u) | (((((((_e871 >> 8u) & 255u) + ((_e877 >> 8u) & 255u)) + 1u) >> 1u) & 255u) << 8u)) | (((((((_e871 >> 16u) & 255u) + ((_e877 >> 16u) & 255u)) + 1u) >> 1u) & 255u) << 16u)) | (((((((_e871 >> 24u) & 255u) + ((_e877 >> 24u) & 255u)) + 1u) >> 1u) & 255u) << 24u);
    uint _e925 = index;
    local_23 = static_cast<uint>(base_1 + 7u);
    uint _e930 = local_23;
    output[_e930] = _e925;
    int _e945 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((4294967295u & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((0u & 65535u) ^ 32768u)) - as_type<uint>(32768))));
    int _e969 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((4294967295u >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((0u >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))));
    local_24 = static_cast<uint>(base_1 + 8u);
    uint _e983 = local_24;
    output[_e983] = (static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e945) + as_type<uint>((_e945 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e969) + as_type<uint>((_e969 < 0) ? -1 : 1)), 2)) + as_type<uint>(65536))) & 65535u) << 16u);
    int _e998 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((4261281277u & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((0u & 255u) ^ 128u)) - as_type<uint>(128))));
    int _e1022 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((4261281277u >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((0u >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))));
    int _e1043 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((4261281277u >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((0u >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))));
    int _e1064 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((4261281277u >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((0u >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))));
    local_25 = static_cast<uint>(base_1 + 9u);
    uint _e1078 = local_25;
    output[_e1078] = (((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e998) + as_type<uint>((_e998 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e1022) + as_type<uint>((_e1022 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e1043) + as_type<uint>((_e1043 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(naga_div(as_type<int>(as_type<uint>(_e1064) + as_type<uint>((_e1064 < 0) ? -1 : 1)), 2)) + as_type<uint>(256))) & 255u) << 24u);
    local_26 = static_cast<uint>(base_1 + 10u);
    uint _e1105 = local_26;
    output[_e1105] = (((((4294967295u & 65535u) + (0u & 65535u)) + 1u) >> 1u) & 65535u) | (((((((4294967295u >> 16u) & 65535u) + ((0u >> 16u) & 65535u)) + 1u) >> 1u) & 65535u) << 16u);
    local_27 = static_cast<uint>(base_1 + 11u);
    uint _e1154 = local_27;
    output[_e1154] = (((((((4294967295u & 255u) + (4294967295u & 255u)) + 1u) >> 1u) & 255u) | (((((((4294967295u >> 8u) & 255u) + ((4294967295u >> 8u) & 255u)) + 1u) >> 1u) & 255u) << 8u)) | (((((((4294967295u >> 16u) & 255u) + ((4294967295u >> 16u) & 255u)) + 1u) >> 1u) & 255u) << 16u)) | (((((((4294967295u >> 24u) & 255u) + ((4294967295u >> 24u) & 255u)) + 1u) >> 1u) & 255u) << 24u);
}
