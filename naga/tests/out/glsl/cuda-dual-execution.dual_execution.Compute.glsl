#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_4_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };


int step_(int value_1) {
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = (_e3 + 3);
    int _e5 = value_2;
    return _e5;
}

int doubled(int value_3) {
    int _e1 = step_(value_3);
    return (_e1 * 2);
}

uint advance(uint value_4) {
    return (value_4 + 5u);
}

uint retreat(uint value_5) {
    return (value_5 - 2u);
}

float scale(float value_6, int bias) {
    return ((value_6 * 2.0) + float(bias));
}

bool same(int left, int right) {
    return (left == right);
}

void consume(bool stop, int value_7) {
    int value_8 = 0;
    value_8 = value_7;
    if (stop) {
        return;
    }
    int _e3 = value_8;
    int _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

void forward(bool stop_1, int value_9) {
    int _e2 = step_(value_9);
    consume(stop_1, _e2);
    return;
}

int device_only(int value_10) {
    int _e1 = step_(value_10);
    return (_e1 + 1);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint out_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint base = 0u;
    int value = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27 = 0u;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    int local_30 = 0;
    int local_31 = 0;
    int local_32 = 0;
    uint local_33[2] = uint[2](0u, 0u);
    uint local_34 = 0u;
    uint local_35 = 0u;
    int local_36 = 0;
    uint local_37[2] = uint[2](0u, 0u);
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40[2] = uint[2](0u, 0u);
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43[2] = uint[2](0u, 0u);
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46[2] = uint[2](0u, 0u);
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49[2] = uint[2](0u, 0u);
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52[2] = uint[2](0u, 0u);
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55[2] = uint[2](0u, 0u);
    uint local_56 = 0u;
    uint local_57 = 0u;
    int local_58 = 0;
    uint local_59[2] = uint[2](0u, 0u);
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62[2] = uint[2](0u, 0u);
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65[2] = uint[2](0u, 0u);
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68[2] = uint[2](0u, 0u);
    uint local_69 = 0u;
    uint local_70 = 0u;
    int local_71 = 0;
    uint local_72[2] = uint[2](0u, 0u);
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75[2] = uint[2](0u, 0u);
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78[2] = uint[2](0u, 0u);
    uint local_79 = 0u;
    uint local_80 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 1u;
    input_[1] = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        uint _e27[2] = input_;
        local = _e27;
        local_1 = uint(i);
        uint _e31[2] = local;
        local_33 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_33[1];
        local_33[1] = (_e35 + _e33);
        uint _e39 = local_33[0];
        local_34 = uint(_e39);
        uint _e43 = local_33[1];
        local_35 = uint(_e43);
        uint _e46 = local_35;
        int _e49 = _group_0_binding_1_cs[_e46];
        local_36 = _e49;
        int _e51 = local_36;
        local_30 = _e51;
        int _e53 = local_30;
        value = _e53;
        int _e55 = value;
        int _e56 = step_(_e55);
        uint _e58[2] = out_;
        local_2 = _e58;
        uint _e60 = base;
        local_3 = uint(_e60);
        uint _e63[2] = local_2;
        local_37 = _e63;
        uint _e65 = local_3;
        uint _e67 = local_37[1];
        local_37[1] = (_e67 + _e65);
        uint _e71 = local_37[0];
        local_38 = uint(_e71);
        uint _e75 = local_37[1];
        local_39 = uint(_e75);
        uint _e78 = local_39;
        _group_0_binding_0_cs[_e78] = _e56;
        int _e81 = value;
        uint _e82[2] = out_;
        local_4 = _e82;
        uint _e84 = base;
        local_5 = uint((_e84 + 1u));
        uint _e89[2] = local_4;
        local_40 = _e89;
        uint _e91 = local_5;
        uint _e93 = local_40[1];
        local_40[1] = (_e93 + _e91);
        uint _e97 = local_40[0];
        local_41 = uint(_e97);
        uint _e101 = local_40[1];
        local_42 = uint(_e101);
        uint _e104 = local_42;
        _group_0_binding_0_cs[_e104] = _e81;
        int _e106 = value;
        int _e107 = doubled(_e106);
        uint _e108[2] = out_;
        local_6 = _e108;
        uint _e110 = base;
        local_7 = uint((_e110 + 2u));
        uint _e115[2] = local_6;
        local_43 = _e115;
        uint _e117 = local_7;
        uint _e119 = local_43[1];
        local_43[1] = (_e119 + _e117);
        uint _e123 = local_43[0];
        local_44 = uint(_e123);
        uint _e127 = local_43[1];
        local_45 = uint(_e127);
        uint _e130 = local_45;
        _group_0_binding_0_cs[_e130] = _e107;
        int _e132 = value;
        uint _e134 = advance(uint(_e132));
        uint _e135[2] = out_;
        local_8 = _e135;
        uint _e137 = base;
        local_9 = uint((_e137 + 3u));
        uint _e143[2] = local_8;
        local_46 = _e143;
        uint _e145 = local_9;
        uint _e147 = local_46[1];
        local_46[1] = (_e147 + _e145);
        uint _e151 = local_46[0];
        local_47 = uint(_e151);
        uint _e155 = local_46[1];
        local_48 = uint(_e155);
        uint _e158 = local_48;
        _group_0_binding_0_cs[_e158] = int(_e134);
        int _e160 = value;
        uint _e162 = retreat(uint(_e160));
        uint _e163[2] = out_;
        local_10 = _e163;
        uint _e165 = base;
        local_11 = uint((_e165 + 4u));
        uint _e171[2] = local_10;
        local_49 = _e171;
        uint _e173 = local_11;
        uint _e175 = local_49[1];
        local_49[1] = (_e175 + _e173);
        uint _e179 = local_49[0];
        local_50 = uint(_e179);
        uint _e183 = local_49[1];
        local_51 = uint(_e183);
        uint _e186 = local_51;
        _group_0_binding_0_cs[_e186] = int(_e162);
        int _e188 = value;
        float _e191 = scale(float(_e188), 4);
        uint _e192[2] = out_;
        local_12 = _e192;
        uint _e194 = base;
        local_13 = uint((_e194 + 5u));
        uint _e200[2] = local_12;
        local_52 = _e200;
        uint _e202 = local_13;
        uint _e204 = local_52[1];
        local_52[1] = (_e204 + _e202);
        uint _e208 = local_52[0];
        local_53 = uint(_e208);
        uint _e212 = local_52[1];
        local_54 = uint(_e212);
        uint _e215 = local_54;
        _group_0_binding_0_cs[_e215] = int(_e191);
        int _e217 = value;
        uint _e218[2] = input_;
        local_16 = _e218;
        local_17 = uint(i);
        uint _e222[2] = local_16;
        local_55 = _e222;
        uint _e224 = local_17;
        uint _e226 = local_55[1];
        local_55[1] = (_e226 + _e224);
        uint _e230 = local_55[0];
        local_56 = uint(_e230);
        uint _e234 = local_55[1];
        local_57 = uint(_e234);
        uint _e237 = local_57;
        int _e239 = _group_0_binding_1_cs[_e237];
        local_58 = _e239;
        int _e241 = local_58;
        local_31 = _e241;
        int _e243 = local_31;
        bool _e244 = same(_e217, _e243);
        uint _e245[2] = out_;
        local_14 = _e245;
        uint _e247 = base;
        local_15 = uint((_e247 + 6u));
        uint _e253[2] = local_14;
        local_59 = _e253;
        uint _e255 = local_15;
        uint _e257 = local_59[1];
        local_59[1] = (_e257 + _e255);
        uint _e261 = local_59[0];
        local_60 = uint(_e261);
        uint _e265 = local_59[1];
        local_61 = uint(_e265);
        uint _e268 = local_61;
        _group_0_binding_0_cs[_e268] = int(_e244);
        int _e274 = value;
        value = (_e274 + 1);
        consume(((i - 2u * (i / 2u)) == 0u), _e274);
        int _e277 = value;
        uint _e278[2] = out_;
        local_18 = _e278;
        uint _e280 = base;
        local_19 = uint((_e280 + 7u));
        uint _e285[2] = local_18;
        local_62 = _e285;
        uint _e287 = local_19;
        uint _e289 = local_62[1];
        local_62[1] = (_e289 + _e287);
        uint _e293 = local_62[0];
        local_63 = uint(_e293);
        uint _e297 = local_62[1];
        local_64 = uint(_e297);
        uint _e300 = local_64;
        _group_0_binding_0_cs[_e300] = _e277;
        int _e306 = value;
        value = (_e306 + 1);
        forward(((i - 2u * (i / 2u)) != 0u), _e306);
        int _e309 = value;
        uint _e310[2] = out_;
        local_20 = _e310;
        uint _e312 = base;
        local_21 = uint((_e312 + 8u));
        uint _e317[2] = local_20;
        local_65 = _e317;
        uint _e319 = local_21;
        uint _e321 = local_65[1];
        local_65[1] = (_e321 + _e319);
        uint _e325 = local_65[0];
        local_66 = uint(_e325);
        uint _e329 = local_65[1];
        local_67 = uint(_e329);
        uint _e332 = local_67;
        _group_0_binding_0_cs[_e332] = _e309;
        int _e334 = value;
        uint _e335[2] = input_;
        local_24 = _e335;
        local_25 = uint(i);
        uint _e339[2] = local_24;
        local_68 = _e339;
        uint _e341 = local_25;
        uint _e343 = local_68[1];
        local_68[1] = (_e343 + _e341);
        uint _e347 = local_68[0];
        local_69 = uint(_e347);
        uint _e351 = local_68[1];
        local_70 = uint(_e351);
        uint _e354 = local_70;
        int _e356 = _group_0_binding_1_cs[_e354];
        local_71 = _e356;
        int _e358 = local_71;
        local_32 = _e358;
        int _e360 = local_32;
        bool _e361 = same(_e334, _e360);
        uint _e362[2] = out_;
        local_22 = _e362;
        uint _e364 = base;
        local_23 = uint((_e364 + 9u));
        uint _e370[2] = local_22;
        local_72 = _e370;
        uint _e372 = local_23;
        uint _e374 = local_72[1];
        local_72[1] = (_e374 + _e372);
        uint _e378 = local_72[0];
        local_73 = uint(_e378);
        uint _e382 = local_72[1];
        local_74 = uint(_e382);
        uint _e385 = local_74;
        _group_0_binding_0_cs[_e385] = int(_e361);
        int _e387 = value;
        int _e388 = step_(_e387);
        int _e389 = device_only(_e388);
        uint _e390[2] = out_;
        local_26 = _e390;
        uint _e392 = base;
        local_27 = uint((_e392 + 10u));
        uint _e397[2] = local_26;
        local_75 = _e397;
        uint _e399 = local_27;
        uint _e401 = local_75[1];
        local_75[1] = (_e401 + _e399);
        uint _e405 = local_75[0];
        local_76 = uint(_e405);
        uint _e409 = local_75[1];
        local_77 = uint(_e409);
        uint _e412 = local_77;
        _group_0_binding_0_cs[_e412] = _e389;
        int _e414 = value;
        uint _e415[2] = out_;
        local_28 = _e415;
        uint _e417 = base;
        local_29 = uint((_e417 + 11u));
        uint _e422[2] = local_28;
        local_78 = _e422;
        uint _e424 = local_29;
        uint _e426 = local_78[1];
        local_78[1] = (_e426 + _e424);
        uint _e430 = local_78[0];
        local_79 = uint(_e430);
        uint _e434 = local_78[1];
        local_80 = uint(_e434);
        uint _e437 = local_80;
        _group_0_binding_0_cs[_e437] = _e414;
    }
}

