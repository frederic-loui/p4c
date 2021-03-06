#include <core.p4>
#define V1MODEL_VERSION 20180101
#include <v1model.p4>

typedef bit<48> Eth0_t;
typedef bit<48> Eth1_t;
typedef bit<48> Eth2_t;
typedef bit<8> Custom0_t;
typedef bit<8> Custom1_t;
typedef bit<8> Custom2_t;
typedef Custom0_t Custom00_t;
typedef Custom0_t Custom01_t;
typedef Custom0_t Custom02_t;
typedef Custom1_t Custom10_t;
typedef Custom1_t Custom11_t;
typedef Custom1_t Custom12_t;
typedef Custom2_t Custom20_t;
typedef Custom2_t Custom21_t;
typedef Custom2_t Custom22_t;
typedef Custom00_t Custom001_t;
typedef Custom00_t Custom002_t;
typedef Custom10_t Custom101_t;
typedef Custom10_t Custom102_t;
typedef Custom20_t Custom201_t;
typedef Custom20_t Custom202_t;
typedef Custom22_t Custom220_t;
typedef Custom002_t Custom0020_t;
typedef Custom0020_t Custom00200_t;
typedef Custom00200_t Custom002001_t;
typedef Custom00200_t Custom002002_t;
typedef Custom002001_t Custom0020010_t;
typedef Custom002002_t Custom0020020_t;
typedef int<8> serenum0_t;
header ethernet_t {
    Eth0_t  dstAddr;
    Eth1_t  srcAddr;
    bit<16> etherType;
}

struct struct1_t {
    bit<7> x;
    bit<9> y;
}

header custom_t {
    bit<48> _addr00;
    bit<48> _addr11;
    bit<48> _addr22;
    bit<8>  _e3;
    bit<8>  _e04;
    bit<8>  _e15;
    bit<8>  _e26;
    bit<8>  _e007;
    bit<8>  _e018;
    bit<8>  _e029;
    bit<8>  _e1010;
    bit<8>  _e1111;
    bit<8>  _e1212;
    bit<8>  _e2013;
    bit<8>  _e2114;
    bit<8>  _e2215;
    bit<8>  _e00116;
    bit<8>  _e00217;
    bit<8>  _e10118;
    bit<8>  _e10219;
    bit<8>  _e20120;
    bit<8>  _e20221;
    bit<8>  _e22022;
    bit<8>  _e002001023;
    bit<8>  _e002002024;
    bit<7>  _my_nested_struct1_x25;
    bit<9>  _my_nested_struct1_y26;
    bit<16> _checksum27;
    int<8>  _s028;
}

@controller_header("packet_in") header packet_in_header_t {
    bit<8> punt_reason;
}

@controller_header("packet_out") header packet_out_header_t {
    Eth0_t          addr0;
    Eth1_t          addr1;
    Eth2_t          addr2;
    bit<8>          e;
    Custom0_t       e0;
    Custom1_t       e1;
    Custom2_t       e2;
    Custom00_t      e00;
    Custom01_t      e01;
    Custom02_t      e02;
    Custom10_t      e10;
    Custom11_t      e11;
    Custom12_t      e12;
    Custom20_t      e20;
    Custom21_t      e21;
    Custom22_t      e22;
    Custom001_t     e001;
    Custom002_t     e002;
    Custom101_t     e101;
    Custom102_t     e102;
    Custom201_t     e201;
    Custom202_t     e202;
    Custom220_t     e220;
    Custom0020010_t e0020010;
    Custom0020020_t e0020020;
}

struct headers_t {
    packet_in_header_t  packet_in;
    packet_out_header_t packet_out;
    ethernet_t          ethernet;
    custom_t            custom;
}

struct valueset1_t {
    Eth0_t     addr0;
    bit<8>     e;
    Custom0_t  e0;
    Custom00_t e00;
}

struct metadata_t {
}

parser ParserImpl(packet_in packet, out headers_t hdr, inout metadata_t meta, inout standard_metadata_t stdmeta) {
    @name("ParserImpl.valueset1") value_set<valueset1_t>(4) valueset1_0;
    state start {
        transition select(stdmeta.ingress_port) {
            9w0: parse_packet_out_header;
            default: parse_ethernet;
        }
    }
    state parse_packet_out_header {
        packet.extract<packet_out_header_t>(hdr.packet_out);
        transition select(hdr.packet_out.addr0, hdr.packet_out.e, hdr.packet_out.e0, hdr.packet_out.e00) {
            valueset1_0: accept;
            default: parse_ethernet;
        }
    }
    state parse_ethernet {
        packet.extract<ethernet_t>(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            16w0xdead: parse_custom;
            default: accept;
        }
    }
    state parse_custom {
        packet.extract<custom_t>(hdr.custom);
        transition accept;
    }
}

control ingress(inout headers_t hdr, inout metadata_t meta, inout standard_metadata_t stdmeta) {
    @name("ingress.set_output") action set_output(@name("out_port") bit<9> out_port) {
        stdmeta.egress_spec = out_port;
    }
    @name("ingress.set_headers") action set_headers(@name("addr0") Eth0_t addr0_1, @name("addr1") Eth1_t addr1_1, @name("addr2") Eth2_t addr2_1, @name("e") bit<8> e_1, @name("e0") Custom0_t e0_1, @name("e1") Custom1_t e1_1, @name("e2") Custom2_t e2_1, @name("e00") Custom00_t e00_1, @name("e01") Custom01_t e01_1, @name("e02") Custom02_t e02_1, @name("e10") Custom10_t e10_1, @name("e11") Custom11_t e11_1, @name("e12") Custom12_t e12_1, @name("e20") Custom20_t e20_1, @name("e21") Custom21_t e21_1, @name("e22") Custom22_t e22_1, @name("e001") Custom001_t e001_1, @name("e002") Custom002_t e002_1, @name("e101") Custom101_t e101_1, @name("e102") Custom102_t e102_1, @name("e201") Custom201_t e201_1, @name("e202") Custom202_t e202_1, @name("e220") Custom220_t e220_1, @name("e0020010") Custom0020010_t e0020010_1, @name("e0020020") Custom0020020_t e0020020_1, @name("s0") int<8> s0_1) {
        hdr.custom._addr00 = addr0_1;
        hdr.custom._addr11 = addr1_1;
        hdr.custom._addr22 = addr2_1;
        hdr.custom._e3 = e_1;
        hdr.custom._e04 = e0_1;
        hdr.custom._e15 = e1_1;
        hdr.custom._e26 = e2_1;
        hdr.custom._e007 = e00_1;
        hdr.custom._e018 = e01_1;
        hdr.custom._e029 = e02_1;
        hdr.custom._e1010 = e10_1;
        hdr.custom._e1111 = e11_1;
        hdr.custom._e1212 = e12_1;
        hdr.custom._e2013 = e20_1;
        hdr.custom._e2114 = e21_1;
        hdr.custom._e2215 = e22_1;
        hdr.custom._e00116 = e001_1;
        hdr.custom._e00217 = e002_1;
        hdr.custom._e10118 = e101_1;
        hdr.custom._e10219 = e102_1;
        hdr.custom._e20120 = e201_1;
        hdr.custom._e20221 = e202_1;
        hdr.custom._e22022 = e220_1;
        hdr.custom._e002001023 = e0020010_1;
        hdr.custom._e002002024 = e0020020_1;
        hdr.custom._s028 = s0_1;
    }
    @name("ingress.my_drop") action my_drop() {
    }
    @name("ingress.custom_table") table custom_table_0 {
        key = {
            hdr.custom._addr00    : exact @name("hdr.custom.addr0") ;
            hdr.custom._addr11    : exact @name("hdr.custom.addr1") ;
            hdr.custom._addr22    : exact @name("hdr.custom.addr2") ;
            hdr.custom._e3        : exact @name("hdr.custom.e") ;
            hdr.custom._e04       : exact @name("hdr.custom.e0") ;
            hdr.custom._e15       : exact @name("hdr.custom.e1") ;
            hdr.custom._e26       : exact @name("hdr.custom.e2") ;
            hdr.custom._e007      : exact @name("hdr.custom.e00") ;
            hdr.custom._e018      : exact @name("hdr.custom.e01") ;
            hdr.custom._e029      : exact @name("hdr.custom.e02") ;
            hdr.custom._e1010     : exact @name("hdr.custom.e10") ;
            hdr.custom._e1111     : exact @name("hdr.custom.e11") ;
            hdr.custom._e1212     : exact @name("hdr.custom.e12") ;
            hdr.custom._e2013     : exact @name("hdr.custom.e20") ;
            hdr.custom._e2114     : exact @name("hdr.custom.e21") ;
            hdr.custom._e2215     : exact @name("hdr.custom.e22") ;
            hdr.custom._e00116    : exact @name("hdr.custom.e001") ;
            hdr.custom._e00217    : exact @name("hdr.custom.e002") ;
            hdr.custom._e10118    : exact @name("hdr.custom.e101") ;
            hdr.custom._e10219    : exact @name("hdr.custom.e102") ;
            hdr.custom._e20120    : exact @name("hdr.custom.e201") ;
            hdr.custom._e20221    : exact @name("hdr.custom.e202") ;
            hdr.custom._e22022    : exact @name("hdr.custom.e220") ;
            hdr.custom._e002001023: exact @name("hdr.custom.e0020010") ;
            hdr.custom._e002002024: exact @name("hdr.custom.e0020020") ;
            hdr.custom._s028      : exact @name("hdr.custom.s0") ;
        }
        actions = {
            set_output();
            set_headers();
            my_drop();
        }
        default_action = my_drop();
    }
    apply {
        if (hdr.custom.isValid()) {
            custom_table_0.apply();
        }
    }
}

control egress(inout headers_t hdr, inout metadata_t meta, inout standard_metadata_t stdmeta) {
    apply {
    }
}

control DeparserImpl(packet_out packet, in headers_t hdr) {
    apply {
        packet.emit<ethernet_t>(hdr.ethernet);
        packet.emit<custom_t>(hdr.custom);
    }
}

struct tuple_0 {
    bit<48> f0;
    bit<48> f1;
    bit<48> f2;
    bit<8>  f3;
    bit<8>  f4;
    bit<8>  f5;
    bit<8>  f6;
    bit<8>  f7;
    bit<8>  f8;
    bit<8>  f9;
    bit<8>  f10;
    bit<8>  f11;
    bit<8>  f12;
    bit<8>  f13;
    bit<8>  f14;
    bit<8>  f15;
    bit<8>  f16;
    bit<8>  f17;
    bit<8>  f18;
    bit<8>  f19;
    bit<8>  f20;
    bit<8>  f21;
    bit<8>  f22;
    bit<8>  f23;
    bit<8>  f24;
    int<8>  f25;
}

control verifyChecksum(inout headers_t hdr, inout metadata_t meta) {
    apply {
        verify_checksum<tuple_0, bit<16>>(hdr.custom.isValid(), { hdr.custom._addr00, hdr.custom._addr11, hdr.custom._addr22, hdr.custom._e3, hdr.custom._e04, hdr.custom._e15, hdr.custom._e26, hdr.custom._e007, hdr.custom._e018, hdr.custom._e029, hdr.custom._e1010, hdr.custom._e1111, hdr.custom._e1212, hdr.custom._e2013, hdr.custom._e2114, hdr.custom._e2215, hdr.custom._e00116, hdr.custom._e00217, hdr.custom._e10118, hdr.custom._e10219, hdr.custom._e20120, hdr.custom._e20221, hdr.custom._e22022, hdr.custom._e002001023, hdr.custom._e002002024, hdr.custom._s028 }, hdr.custom._checksum27, HashAlgorithm.csum16);
    }
}

control computeChecksum(inout headers_t hdr, inout metadata_t meta) {
    apply {
        update_checksum<tuple_0, bit<16>>(hdr.custom.isValid(), { hdr.custom._addr00, hdr.custom._addr11, hdr.custom._addr22, hdr.custom._e3, hdr.custom._e04, hdr.custom._e15, hdr.custom._e26, hdr.custom._e007, hdr.custom._e018, hdr.custom._e029, hdr.custom._e1010, hdr.custom._e1111, hdr.custom._e1212, hdr.custom._e2013, hdr.custom._e2114, hdr.custom._e2215, hdr.custom._e00116, hdr.custom._e00217, hdr.custom._e10118, hdr.custom._e10219, hdr.custom._e20120, hdr.custom._e20221, hdr.custom._e22022, hdr.custom._e002001023, hdr.custom._e002002024, hdr.custom._s028 }, hdr.custom._checksum27, HashAlgorithm.csum16);
    }
}

V1Switch<headers_t, metadata_t>(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;

