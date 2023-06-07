//  This file is generated by make_generated_offload_arch_h.sh
//  It is only included by OffloadArch.cpp
#include <stddef.h>
#include <stdint.h>
typedef enum {
  AOT_GFX1010,
  AOT_GFX1011,
  AOT_GFX1012,
  AOT_GFX1013,
  AOT_GFX1030,
  AOT_GFX1031,
  AOT_GFX1032,
  AOT_GFX1033,
  AOT_GFX1034,
  AOT_GFX1035,
  AOT_GFX1036,
  AOT_GFX1100,
  AOT_GFX1101,
  AOT_GFX1102,
  AOT_GFX1103,
  AOT_GFX700,
  AOT_GFX701,
  AOT_GFX801,
  AOT_GFX802,
  AOT_GFX803,
  AOT_GFX900,
  AOT_GFX902,
  AOT_GFX904,
  AOT_GFX906,
  AOT_GFX908,
  AOT_GFX90A,
  AOT_GFX90C,
  AOT_SM_30,
  AOT_SM_35,
  AOT_SM_50,
  AOT_SM_60,
  AOT_SM_61,
  AOT_SM_70,
} AOT_OFFLOADARCH;
typedef enum {
  AOT_CN_ALDEBARAN,
  AOT_CN_ARCTURUS,
  AOT_CN_BEIGE_GOBY,
  AOT_CN_CARRIZO,
  AOT_CN_CYAN_SKILLFISH,
  AOT_CN_DIMGREY_CAVEFISH,
  AOT_CN_FIJI,
  AOT_CN_HAWAII,
  AOT_CN_HOTPINK_BONEFISH,
  AOT_CN_NAVI10,
  AOT_CN_NAVI12,
  AOT_CN_NAVI14,
  AOT_CN_NAVY_FLOUNDER,
  AOT_CN_PINK_SARDINE,
  AOT_CN_PLUM_BONITO,
  AOT_CN_POLARIS10,
  AOT_CN_POLARIS11,
  AOT_CN_POLARIS12,
  AOT_CN_RAPHAEL,
  AOT_CN_RAVEN,
  AOT_CN_REMBRANDT,
  AOT_CN_RENOIR,
  AOT_CN_SIENNA_CICHLID,
  AOT_CN_SPECTRE,
  AOT_CN_SPOOKY,
  AOT_CN_TONGA,
  AOT_CN_VANGOGH,
  AOT_CN_VEGA10,
  AOT_CN_VEGA12,
  AOT_CN_VEGA20,
  AOT_CN_VEGAM,
  AOT_CN_WHEAT_NAS,
  AOT_CN_YELLOW_CARP,
  AOT_CN_K4000,
  AOT_CN_K4200,
  AOT_CN_GTX750,
  AOT_CN_GTX960M,
  AOT_CN_GTX980,
  AOT_CN_GTX1050,
  AOT_CN_GTX1060,
  AOT_CN_GTX1080,
  AOT_CN_GT730,
  AOT_CN_P100,
  AOT_CN_GV100,
  AOT_CN_V100,
} AOT_CODENAME;

struct AOT_CODENAME_ID_TO_STRING{
  AOT_CODENAME codename_id;
  const char* codename;
};

struct AOT_OFFLOADARCH_TO_STRING{
  AOT_OFFLOADARCH offloadarch_id;
  const char* offloadarch;
};

struct AOT_TABLE_ENTRY{
    uint16_t vendorid;
    uint16_t devid;
    AOT_CODENAME codename_id;
    AOT_OFFLOADARCH offloadarch_id;
};
extern const AOT_CODENAME_ID_TO_STRING AOT_CODENAMES[] =  {
  {AOT_CN_ALDEBARAN, "ALDEBARAN"},
  {AOT_CN_ARCTURUS, "ARCTURUS"},
  {AOT_CN_BEIGE_GOBY, "BEIGE_GOBY"},
  {AOT_CN_CARRIZO, "CARRIZO"},
  {AOT_CN_CYAN_SKILLFISH, "CYAN_SKILLFISH"},
  {AOT_CN_DIMGREY_CAVEFISH, "DIMGREY_CAVEFISH"},
  {AOT_CN_FIJI, "FIJI"},
  {AOT_CN_HAWAII, "HAWAII"},
  {AOT_CN_HOTPINK_BONEFISH, "HOTPINK_BONEFISH"},
  {AOT_CN_NAVI10, "NAVI10"},
  {AOT_CN_NAVI12, "NAVI12"},
  {AOT_CN_NAVI14, "NAVI14"},
  {AOT_CN_NAVY_FLOUNDER, "NAVY_FLOUNDER"},
  {AOT_CN_PINK_SARDINE, "PINK_SARDINE"},
  {AOT_CN_PLUM_BONITO, "PLUM_BONITO"},
  {AOT_CN_POLARIS10, "POLARIS10"},
  {AOT_CN_POLARIS11, "POLARIS11"},
  {AOT_CN_POLARIS12, "POLARIS12"},
  {AOT_CN_RAPHAEL, "RAPHAEL"},
  {AOT_CN_RAVEN, "RAVEN"},
  {AOT_CN_REMBRANDT, "REMBRANDT"},
  {AOT_CN_RENOIR, "RENOIR"},
  {AOT_CN_SIENNA_CICHLID, "SIENNA_CICHLID"},
  {AOT_CN_SPECTRE, "SPECTRE"},
  {AOT_CN_SPOOKY, "SPOOKY"},
  {AOT_CN_TONGA, "TONGA"},
  {AOT_CN_VANGOGH, "VANGOGH"},
  {AOT_CN_VEGA10, "VEGA10"},
  {AOT_CN_VEGA12, "VEGA12"},
  {AOT_CN_VEGA20, "VEGA20"},
  {AOT_CN_VEGAM, "VEGAM"},
  {AOT_CN_WHEAT_NAS, "WHEAT_NAS"},
  {AOT_CN_YELLOW_CARP, "YELLOW_CARP"},
  {AOT_CN_K4000, "k4000"},
  {AOT_CN_K4200, "k4200"},
  {AOT_CN_GTX750, "gtx750"},
  {AOT_CN_GTX960M, "gtx960m"},
  {AOT_CN_GTX980, "gtx980"},
  {AOT_CN_GTX1050, "gtx1050"},
  {AOT_CN_GTX1060, "gtx1060"},
  {AOT_CN_GTX1080, "gtx1080"},
  {AOT_CN_GT730, "gt730"},
  {AOT_CN_P100, "p100"},
  {AOT_CN_GV100, "gv100"},
  {AOT_CN_V100, "v100"},
};
extern const AOT_OFFLOADARCH_TO_STRING AOT_OFFLOADARCHS[] =  {
  {AOT_GFX1010, "gfx1010"},
  {AOT_GFX1011, "gfx1011"},
  {AOT_GFX1012, "gfx1012"},
  {AOT_GFX1013, "gfx1013"},
  {AOT_GFX1030, "gfx1030"},
  {AOT_GFX1031, "gfx1031"},
  {AOT_GFX1032, "gfx1032"},
  {AOT_GFX1033, "gfx1033"},
  {AOT_GFX1034, "gfx1034"},
  {AOT_GFX1035, "gfx1035"},
  {AOT_GFX1036, "gfx1036"},
  {AOT_GFX1100, "gfx1100"},
  {AOT_GFX1101, "gfx1101"},
  {AOT_GFX1102, "gfx1102"},
  {AOT_GFX1103, "gfx1103"},
  {AOT_GFX700, "gfx700"},
  {AOT_GFX701, "gfx701"},
  {AOT_GFX801, "gfx801"},
  {AOT_GFX802, "gfx802"},
  {AOT_GFX803, "gfx803"},
  {AOT_GFX900, "gfx900"},
  {AOT_GFX902, "gfx902"},
  {AOT_GFX904, "gfx904"},
  {AOT_GFX906, "gfx906"},
  {AOT_GFX908, "gfx908"},
  {AOT_GFX90A, "gfx90a"},
  {AOT_GFX90C, "gfx90c"},
  {AOT_SM_30, "sm_30"},
  {AOT_SM_35, "sm_35"},
  {AOT_SM_50, "sm_50"},
  {AOT_SM_60, "sm_60"},
  {AOT_SM_61, "sm_61"},
  {AOT_SM_70, "sm_70"},
};
extern const AOT_TABLE_ENTRY AOT_TABLE[] = {
{ 0x1002, 0x1304, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1305, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1306, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1307, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1309, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x130A, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x130B, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x130C, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x130D, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x130E, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x130F, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1310, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1311, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1312, AOT_CN_SPOOKY, AOT_GFX700 },
{ 0x1002, 0x1313, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1315, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x1316, AOT_CN_SPOOKY, AOT_GFX700 },
{ 0x1002, 0x1317, AOT_CN_SPOOKY, AOT_GFX700 },
{ 0x1002, 0x1318, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x131B, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x131C, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x131D, AOT_CN_SPECTRE, AOT_GFX700 },
{ 0x1002, 0x13F9, AOT_CN_CYAN_SKILLFISH, AOT_GFX1013 },
{ 0x1002, 0x13FA, AOT_CN_CYAN_SKILLFISH, AOT_GFX1013 },
{ 0x1002, 0x13FB, AOT_CN_CYAN_SKILLFISH, AOT_GFX1013 },
{ 0x1002, 0x13FC, AOT_CN_CYAN_SKILLFISH, AOT_GFX1013 },
{ 0x1002, 0x13FE, AOT_CN_CYAN_SKILLFISH, AOT_GFX1013 },
{ 0x1002, 0x15D8, AOT_CN_RAVEN, AOT_GFX902 },
{ 0x1002, 0x15DD, AOT_CN_RAVEN, AOT_GFX902 },
{ 0x1002, 0x15E7, AOT_CN_RENOIR, AOT_GFX90C },
{ 0x1002, 0x1636, AOT_CN_RENOIR, AOT_GFX90C },
{ 0x1002, 0x1638, AOT_CN_RENOIR, AOT_GFX90C },
{ 0x1002, 0x163F, AOT_CN_VANGOGH, AOT_GFX1033 },
{ 0x1002, 0x164C, AOT_CN_RENOIR, AOT_GFX90C },
{ 0x1002, 0x164d, AOT_CN_REMBRANDT, AOT_GFX1035 },
{ 0x1002, 0x164D, AOT_CN_YELLOW_CARP, AOT_GFX1035 },
{ 0x1002, 0x164e, AOT_CN_RAPHAEL, AOT_GFX1036 },
{ 0x1002, 0x1681, AOT_CN_YELLOW_CARP, AOT_GFX1035 },
{ 0x1002, 0x66A0, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x66A1, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x66A2, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x66A3, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x66A4, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x66A7, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x66AF, AOT_CN_VEGA20, AOT_GFX906 },
{ 0x1002, 0x67A0, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67A1, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67A2, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67A8, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67A9, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67AA, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67B0, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67B1, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67B8, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67B9, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67BA, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67BE, AOT_CN_HAWAII, AOT_GFX701 },
{ 0x1002, 0x67C0, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67C1, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67C2, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67C4, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67C7, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67C8, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67C9, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67CA, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67CC, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67CF, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67D0, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67DF, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x67E0, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67E1, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67E3, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67E7, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67E8, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67E9, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67EB, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67EF, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x67FF, AOT_CN_POLARIS11, AOT_GFX803 },
{ 0x1002, 0x6860, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6861, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6862, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6863, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6864, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6867, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6868, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6869, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x686A, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x686B, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x686C, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x686D, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x686E, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x687F, AOT_CN_VEGA10, AOT_GFX900 },
{ 0x1002, 0x6920, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x6921, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x6928, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x6929, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x692B, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x692F, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x6930, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x6938, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x6939, AOT_CN_TONGA, AOT_GFX802 },
{ 0x1002, 0x694C, AOT_CN_VEGAM, AOT_GFX803 },
{ 0x1002, 0x694E, AOT_CN_VEGAM, AOT_GFX803 },
{ 0x1002, 0x694F, AOT_CN_VEGAM, AOT_GFX803 },
{ 0x1002, 0x6980, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x6981, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x6985, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x6986, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x6987, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x6995, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x6997, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x699F, AOT_CN_POLARIS12, AOT_GFX803 },
{ 0x1002, 0x69A0, AOT_CN_VEGA12, AOT_GFX904 },
{ 0x1002, 0x69A1, AOT_CN_VEGA12, AOT_GFX904 },
{ 0x1002, 0x69A2, AOT_CN_VEGA12, AOT_GFX904 },
{ 0x1002, 0x69A3, AOT_CN_VEGA12, AOT_GFX904 },
{ 0x1002, 0x69Af, AOT_CN_VEGA12, AOT_GFX904 },
{ 0x1002, 0x6FDF, AOT_CN_POLARIS10, AOT_GFX803 },
{ 0x1002, 0x7300, AOT_CN_FIJI, AOT_GFX803 },
{ 0x1002, 0x730F, AOT_CN_FIJI, AOT_GFX803 },
{ 0x1002, 0x7310, AOT_CN_NAVI10, AOT_GFX1010 },
{ 0x1002, 0x7312, AOT_CN_NAVI10, AOT_GFX1010 },
{ 0x1002, 0x7318, AOT_CN_NAVI10, AOT_GFX1010 },
{ 0x1002, 0x731A, AOT_CN_NAVI10, AOT_GFX1010 },
{ 0x1002, 0x731E, AOT_CN_NAVI10, AOT_GFX1010 },
{ 0x1002, 0x731F, AOT_CN_NAVI10, AOT_GFX1010 },
{ 0x1002, 0x7340, AOT_CN_NAVI14, AOT_GFX1012 },
{ 0x1002, 0x7341, AOT_CN_NAVI14, AOT_GFX1012 },
{ 0x1002, 0x7347, AOT_CN_NAVI14, AOT_GFX1012 },
{ 0x1002, 0x7360, AOT_CN_NAVI12, AOT_GFX1011 },
{ 0x1002, 0x7362, AOT_CN_NAVI12, AOT_GFX1011 },
{ 0x1002, 0x7388, AOT_CN_ARCTURUS, AOT_GFX908 },
{ 0x1002, 0x738C, AOT_CN_ARCTURUS, AOT_GFX908 },
{ 0x1002, 0x738E, AOT_CN_ARCTURUS, AOT_GFX908 },
{ 0x1002, 0x7390, AOT_CN_ARCTURUS, AOT_GFX908 },
{ 0x1002, 0x73A0, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73A1, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73A2, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73A3, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73A5, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73A8, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73A9, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73AB, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73AC, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73AD, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73AE, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73BF, AOT_CN_SIENNA_CICHLID, AOT_GFX1030 },
{ 0x1002, 0x73C0, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73C1, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73C3, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73DA, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73DB, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73DC, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73DD, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73DE, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73DF, AOT_CN_NAVY_FLOUNDER, AOT_GFX1031 },
{ 0x1002, 0x73E0, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73E1, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73E2, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73E8, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73E9, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73EA, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73EB, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73EC, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73ED, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73EF, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x73FF, AOT_CN_DIMGREY_CAVEFISH, AOT_GFX1032 },
{ 0x1002, 0x7408, AOT_CN_ALDEBARAN, AOT_GFX90A },
{ 0x1002, 0x740C, AOT_CN_ALDEBARAN, AOT_GFX90A },
{ 0x1002, 0x740F, AOT_CN_ALDEBARAN, AOT_GFX90A },
{ 0x1002, 0x7410, AOT_CN_ALDEBARAN, AOT_GFX90A },
{ 0x1002, 0x7420, AOT_CN_BEIGE_GOBY, AOT_GFX1034 },
{ 0x1002, 0x7421, AOT_CN_BEIGE_GOBY, AOT_GFX1034 },
{ 0x1002, 0x7422, AOT_CN_BEIGE_GOBY, AOT_GFX1034 },
{ 0x1002, 0x7423, AOT_CN_BEIGE_GOBY, AOT_GFX1034 },
{ 0x1002, 0x743F, AOT_CN_BEIGE_GOBY, AOT_GFX1034 },
{ 0x1002, 0x744C, AOT_CN_PLUM_BONITO, AOT_GFX1100 },
{ 0x1002, 0x9870, AOT_CN_CARRIZO, AOT_GFX801 },
{ 0x1002, 0x9874, AOT_CN_CARRIZO, AOT_GFX801 },
{ 0x1002, 0x9875, AOT_CN_CARRIZO, AOT_GFX801 },
{ 0x1002, 0x9876, AOT_CN_CARRIZO, AOT_GFX801 },
{ 0x1002, 0x9877, AOT_CN_CARRIZO, AOT_GFX801 },
{ 0x10de, 0x0f02, AOT_CN_GT730, AOT_SM_35 },
{ 0x10de, 0x0f06, AOT_CN_GT730, AOT_SM_35 },
{ 0x10de, 0x0fc9, AOT_CN_GT730, AOT_SM_35 },
{ 0x10de, 0x11b4, AOT_CN_K4200, AOT_SM_30 },
{ 0x10de, 0x11c7, AOT_CN_GTX750, AOT_SM_50 },
{ 0x10de, 0x11fa, AOT_CN_K4000, AOT_SM_30 },
{ 0x10de, 0x1287, AOT_CN_GT730, AOT_SM_35 },
{ 0x10de, 0x1380, AOT_CN_GTX750, AOT_SM_50 },
{ 0x10de, 0x1381, AOT_CN_GTX750, AOT_SM_50 },
{ 0x10de, 0x139b, AOT_CN_GTX960M, AOT_SM_50 },
{ 0x10de, 0x139b, AOT_CN_GTX960M, AOT_SM_50 },
{ 0x10de, 0x139b, AOT_CN_GTX960M, AOT_SM_50 },
{ 0x10de, 0x139d, AOT_CN_GTX750, AOT_SM_50 },
{ 0x10de, 0x13c0, AOT_CN_GTX980, AOT_SM_35 },
{ 0x10de, 0x13c0, AOT_CN_GTX980, AOT_SM_35 },
{ 0x10de, 0x13da, AOT_CN_GTX980, AOT_SM_35 },
{ 0x10de, 0x13e7, AOT_CN_GTX980, AOT_SM_35 },
{ 0x10de, 0x1407, AOT_CN_GTX750, AOT_SM_50 },
{ 0x10de, 0x15f7, AOT_CN_P100, AOT_SM_60 },
{ 0x10de, 0x15f8, AOT_CN_P100, AOT_SM_60 },
{ 0x10de, 0x15f9, AOT_CN_P100, AOT_SM_60 },
{ 0x10de, 0x161a, AOT_CN_GTX980, AOT_SM_35 },
{ 0x10de, 0x17c8, AOT_CN_GTX980, AOT_SM_35 },
{ 0x10de, 0x1b06, AOT_CN_GTX1080, AOT_SM_61 },
{ 0x10de, 0x1b80, AOT_CN_GTX1080, AOT_SM_61 },
{ 0x10de, 0x1b83, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1b84, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1ba0, AOT_CN_GTX1080, AOT_SM_61 },
{ 0x10de, 0x1be0, AOT_CN_GTX1080, AOT_SM_61 },
{ 0x10de, 0x1be0, AOT_CN_GTX1080, AOT_SM_61 },
{ 0x10de, 0x1be0, AOT_CN_GTX1080, AOT_SM_61 },
{ 0x10de, 0x1c02, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c03, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c04, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c06, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c20, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c20, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c21, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c22, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c60, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c60, AOT_CN_GTX1060, AOT_SM_61 },
{ 0x10de, 0x1c61, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c62, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c81, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c82, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c83, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c8c, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c8d, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c8f, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1c92, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1ccc, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1ccd, AOT_CN_GTX1050, AOT_SM_61 },
{ 0x10de, 0x1db1, AOT_CN_V100, AOT_SM_70 },
{ 0x10de, 0x1db4, AOT_CN_V100, AOT_SM_70 },
{ 0x10de, 0x1db5, AOT_CN_V100, AOT_SM_70 },
{ 0x10de, 0x1db6, AOT_CN_V100, AOT_SM_70 },
{ 0x10de, 0x1db7, AOT_CN_V100, AOT_SM_70 },
{ 0x10de, 0x1dba, AOT_CN_GV100, AOT_SM_70 },
{ 0x10de, 0x1dba, AOT_CN_GV100, AOT_SM_70 },
};
