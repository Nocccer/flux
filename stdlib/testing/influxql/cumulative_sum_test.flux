package influxql_test


import "testing"
import "internal/influxql"
import "csv"

inData =
    "
#datatype,string,long,dateTime:RFC3339,string,string,string,double
#group,false,false,false,true,true,true,false
#default,0,,,,,,
,result,table,_time,_measurement,t0,_field,_value
,,0,1970-01-01T00:00:00Z,m,0,f,0.19434194999233168
,,0,1970-01-01T01:00:00Z,m,0,f,0.35586976154169886
,,0,1970-01-01T02:00:00Z,m,0,f,0.9008931119054228
,,0,1970-01-01T03:00:00Z,m,0,f,0.6461505985646413
,,0,1970-01-01T04:00:00Z,m,0,f,0.1340222613556339
,,0,1970-01-01T05:00:00Z,m,0,f,0.3050922896043849
,,0,1970-01-01T06:00:00Z,m,0,f,0.16797790004756785
,,0,1970-01-01T07:00:00Z,m,0,f,0.6859900761088404
,,0,1970-01-01T08:00:00Z,m,0,f,0.3813372334346726
,,0,1970-01-01T09:00:00Z,m,0,f,0.37739800802050527
,,0,1970-01-01T10:00:00Z,m,0,f,0.2670215125945959
,,0,1970-01-01T11:00:00Z,m,0,f,0.19857273235709308
,,0,1970-01-01T12:00:00Z,m,0,f,0.7926413090714327
,,0,1970-01-01T13:00:00Z,m,0,f,0.8488436313118317
,,0,1970-01-01T14:00:00Z,m,0,f,0.1960293435787179
,,0,1970-01-01T15:00:00Z,m,0,f,0.27204741679052236
,,0,1970-01-01T16:00:00Z,m,0,f,0.6045056499409555
,,0,1970-01-01T17:00:00Z,m,0,f,0.21508343480255984
,,0,1970-01-01T18:00:00Z,m,0,f,0.2712545253017199
,,0,1970-01-01T19:00:00Z,m,0,f,0.22728191431845607
,,0,1970-01-01T20:00:00Z,m,0,f,0.8232481787306024
,,0,1970-01-01T21:00:00Z,m,0,f,0.9722054606060748
,,0,1970-01-01T22:00:00Z,m,0,f,0.9332942983017809
,,0,1970-01-01T23:00:00Z,m,0,f,0.009704805042322441
,,0,1970-01-02T00:00:00Z,m,0,f,0.4614776151185129
,,0,1970-01-02T01:00:00Z,m,0,f,0.3972854143424396
,,0,1970-01-02T02:00:00Z,m,0,f,0.024157782439736365
,,0,1970-01-02T03:00:00Z,m,0,f,0.7074351703076142
,,0,1970-01-02T04:00:00Z,m,0,f,0.5819899173941508
,,0,1970-01-02T05:00:00Z,m,0,f,0.2974899730817849
,,0,1970-01-02T06:00:00Z,m,0,f,0.3664899570202347
,,0,1970-01-02T07:00:00Z,m,0,f,0.5666625499409519
,,0,1970-01-02T08:00:00Z,m,0,f,0.2592658730352201
,,0,1970-01-02T09:00:00Z,m,0,f,0.6907206550112025
,,0,1970-01-02T10:00:00Z,m,0,f,0.7184801284027215
,,0,1970-01-02T11:00:00Z,m,0,f,0.363103986952813
,,0,1970-01-02T12:00:00Z,m,0,f,0.938825820840304
,,0,1970-01-02T13:00:00Z,m,0,f,0.7034638846507775
,,0,1970-01-02T14:00:00Z,m,0,f,0.5714903231820487
,,0,1970-01-02T15:00:00Z,m,0,f,0.24449047981396105
,,0,1970-01-02T16:00:00Z,m,0,f,0.14165037565843824
,,0,1970-01-02T17:00:00Z,m,0,f,0.05351135846151062
,,0,1970-01-02T18:00:00Z,m,0,f,0.3450781133356193
,,0,1970-01-02T19:00:00Z,m,0,f,0.23254297482426214
,,0,1970-01-02T20:00:00Z,m,0,f,0.15416851272541165
,,0,1970-01-02T21:00:00Z,m,0,f,0.9287113745228632
,,0,1970-01-02T22:00:00Z,m,0,f,0.8464406026410536
,,0,1970-01-02T23:00:00Z,m,0,f,0.7786237155792206
,,0,1970-01-03T00:00:00Z,m,0,f,0.7222630273842695
,,0,1970-01-03T01:00:00Z,m,0,f,0.5702856518144571
,,0,1970-01-03T02:00:00Z,m,0,f,0.4475020612540418
,,0,1970-01-03T03:00:00Z,m,0,f,0.19482413230523188
,,0,1970-01-03T04:00:00Z,m,0,f,0.14555100659831088
,,0,1970-01-03T05:00:00Z,m,0,f,0.3715313467677773
,,0,1970-01-03T06:00:00Z,m,0,f,0.15710124605981904
,,0,1970-01-03T07:00:00Z,m,0,f,0.05115366925369082
,,0,1970-01-03T08:00:00Z,m,0,f,0.49634673580304356
,,0,1970-01-03T09:00:00Z,m,0,f,0.09850492453963475
,,0,1970-01-03T10:00:00Z,m,0,f,0.07088528667647799
,,0,1970-01-03T11:00:00Z,m,0,f,0.9535958852850828
,,0,1970-01-03T12:00:00Z,m,0,f,0.9473123289831784
,,0,1970-01-03T13:00:00Z,m,0,f,0.6321990998686917
,,0,1970-01-03T14:00:00Z,m,0,f,0.5310985616209651
,,0,1970-01-03T15:00:00Z,m,0,f,0.14010236285353878
,,0,1970-01-03T16:00:00Z,m,0,f,0.5143111322693407
,,0,1970-01-03T17:00:00Z,m,0,f,0.1419555013503121
,,0,1970-01-03T18:00:00Z,m,0,f,0.034988171145264535
,,0,1970-01-03T19:00:00Z,m,0,f,0.4646423361131385
,,0,1970-01-03T20:00:00Z,m,0,f,0.7280775859440926
,,0,1970-01-03T21:00:00Z,m,0,f,0.9605223329866902
,,0,1970-01-03T22:00:00Z,m,0,f,0.6294671473626672
,,0,1970-01-03T23:00:00Z,m,0,f,0.09676486946771183
,,0,1970-01-04T00:00:00Z,m,0,f,0.4846624906255957
,,0,1970-01-04T01:00:00Z,m,0,f,0.9000151629241091
,,0,1970-01-04T02:00:00Z,m,0,f,0.8187520581651648
,,0,1970-01-04T03:00:00Z,m,0,f,0.6356479673253379
,,0,1970-01-04T04:00:00Z,m,0,f,0.9172292568869698
,,0,1970-01-04T05:00:00Z,m,0,f,0.25871413585674596
,,0,1970-01-04T06:00:00Z,m,0,f,0.934030201106989
,,0,1970-01-04T07:00:00Z,m,0,f,0.6300301521545785
,,0,1970-01-04T08:00:00Z,m,0,f,0.9898695895471914
,,0,1970-01-04T09:00:00Z,m,0,f,0.6576532850348832
,,0,1970-01-04T10:00:00Z,m,0,f,0.1095953745610317
,,0,1970-01-04T11:00:00Z,m,0,f,0.20714716664645624
,,0,1970-01-04T12:00:00Z,m,0,f,0.49378319061925324
,,0,1970-01-04T13:00:00Z,m,0,f,0.3244630221410883
,,0,1970-01-04T14:00:00Z,m,0,f,0.1425620337332085
,,0,1970-01-04T15:00:00Z,m,0,f,0.37483772088251627
,,0,1970-01-04T16:00:00Z,m,0,f,0.9386123621523778
,,0,1970-01-04T17:00:00Z,m,0,f,0.2944439301474122
,,0,1970-01-04T18:00:00Z,m,0,f,0.8075592894168399
,,0,1970-01-04T19:00:00Z,m,0,f,0.8131183413273094
,,0,1970-01-04T20:00:00Z,m,0,f,0.6056875144431602
,,0,1970-01-04T21:00:00Z,m,0,f,0.5514021237520469
,,0,1970-01-04T22:00:00Z,m,0,f,0.2904517561416824
,,0,1970-01-04T23:00:00Z,m,0,f,0.7773782053605
,,0,1970-01-05T00:00:00Z,m,0,f,0.1390732850129641
,,0,1970-01-05T01:00:00Z,m,0,f,0.36874812027455345
,,0,1970-01-05T02:00:00Z,m,0,f,0.8497133445947114
,,0,1970-01-05T03:00:00Z,m,0,f,0.2842281672817387
,,0,1970-01-05T04:00:00Z,m,0,f,0.5851186942712497
,,0,1970-01-05T05:00:00Z,m,0,f,0.2754694564842422
,,0,1970-01-05T06:00:00Z,m,0,f,0.03545539694267428
,,0,1970-01-05T07:00:00Z,m,0,f,0.4106208929295988
,,0,1970-01-05T08:00:00Z,m,0,f,0.3680257641839746
,,0,1970-01-05T09:00:00Z,m,0,f,0.7484477843640726
,,0,1970-01-05T10:00:00Z,m,0,f,0.2196945379224781
,,0,1970-01-05T11:00:00Z,m,0,f,0.7377409626382783
,,0,1970-01-05T12:00:00Z,m,0,f,0.4340408821652924
,,0,1970-01-05T13:00:00Z,m,0,f,0.04157784831355819
,,0,1970-01-05T14:00:00Z,m,0,f,0.9005324473445669
,,0,1970-01-05T15:00:00Z,m,0,f,0.6243062492954053
,,0,1970-01-05T16:00:00Z,m,0,f,0.4138274722170456
,,0,1970-01-05T17:00:00Z,m,0,f,0.6559961319794279
,,0,1970-01-05T18:00:00Z,m,0,f,0.09452730201881836
,,0,1970-01-05T19:00:00Z,m,0,f,0.35207875464289057
,,0,1970-01-05T20:00:00Z,m,0,f,0.47000290183266497
,,0,1970-01-05T21:00:00Z,m,0,f,0.13384008497720026
,,0,1970-01-05T22:00:00Z,m,0,f,0.2542495300083506
,,0,1970-01-05T23:00:00Z,m,0,f,0.04357411582677676
,,0,1970-01-06T00:00:00Z,m,0,f,0.2730770850239896
,,0,1970-01-06T01:00:00Z,m,0,f,0.07346719069503016
,,0,1970-01-06T02:00:00Z,m,0,f,0.19296870107837727
,,0,1970-01-06T03:00:00Z,m,0,f,0.8550701670111052
,,0,1970-01-06T04:00:00Z,m,0,f,0.9015279993379257
,,0,1970-01-06T05:00:00Z,m,0,f,0.7681329597853651
,,0,1970-01-06T06:00:00Z,m,0,f,0.13458582961527799
,,0,1970-01-06T07:00:00Z,m,0,f,0.5025964032341974
,,0,1970-01-06T08:00:00Z,m,0,f,0.9660611150198847
,,0,1970-01-06T09:00:00Z,m,0,f,0.7406756350132208
,,0,1970-01-06T10:00:00Z,m,0,f,0.48245323402069856
,,0,1970-01-06T11:00:00Z,m,0,f,0.5396866678590079
,,0,1970-01-06T12:00:00Z,m,0,f,0.24056787192459894
,,0,1970-01-06T13:00:00Z,m,0,f,0.5473495899891297
,,0,1970-01-06T14:00:00Z,m,0,f,0.9939487519980328
,,0,1970-01-06T15:00:00Z,m,0,f,0.7718086454038607
,,0,1970-01-06T16:00:00Z,m,0,f,0.3729231862915519
,,0,1970-01-06T17:00:00Z,m,0,f,0.978216628089757
,,0,1970-01-06T18:00:00Z,m,0,f,0.30410501498270626
,,0,1970-01-06T19:00:00Z,m,0,f,0.36293525766110357
,,0,1970-01-06T20:00:00Z,m,0,f,0.45673893698213724
,,0,1970-01-06T21:00:00Z,m,0,f,0.42887470039944864
,,0,1970-01-06T22:00:00Z,m,0,f,0.42264444401794515
,,0,1970-01-06T23:00:00Z,m,0,f,0.3061909271178175
,,0,1970-01-07T00:00:00Z,m,0,f,0.6681291175687905
,,0,1970-01-07T01:00:00Z,m,0,f,0.5494108420781338
,,0,1970-01-07T02:00:00Z,m,0,f,0.31779594303648045
,,0,1970-01-07T03:00:00Z,m,0,f,0.22502703712265368
,,0,1970-01-07T04:00:00Z,m,0,f,0.03498146847868716
,,0,1970-01-07T05:00:00Z,m,0,f,0.16139395876022747
,,0,1970-01-07T06:00:00Z,m,0,f,0.6335318955521227
,,0,1970-01-07T07:00:00Z,m,0,f,0.5854967453622169
,,0,1970-01-07T08:00:00Z,m,0,f,0.43015814365562627
,,0,1970-01-07T09:00:00Z,m,0,f,0.07215482648098204
,,0,1970-01-07T10:00:00Z,m,0,f,0.09348412983453618
,,0,1970-01-07T11:00:00Z,m,0,f,0.9023793546915768
,,0,1970-01-07T12:00:00Z,m,0,f,0.9055451292861832
,,0,1970-01-07T13:00:00Z,m,0,f,0.3280454144164272
,,0,1970-01-07T14:00:00Z,m,0,f,0.05897468763156862
,,0,1970-01-07T15:00:00Z,m,0,f,0.3686339026679373
,,0,1970-01-07T16:00:00Z,m,0,f,0.7547173975990482
,,0,1970-01-07T17:00:00Z,m,0,f,0.457847526142958
,,0,1970-01-07T18:00:00Z,m,0,f,0.5038320054556072
,,0,1970-01-07T19:00:00Z,m,0,f,0.47058145000588336
,,0,1970-01-07T20:00:00Z,m,0,f,0.5333903317331339
,,0,1970-01-07T21:00:00Z,m,0,f,0.1548508614296064
,,0,1970-01-07T22:00:00Z,m,0,f,0.6837681053869291
,,0,1970-01-07T23:00:00Z,m,0,f,0.9081953381867953
,,1,1970-01-01T00:00:00Z,m,1,f,0.15129694889144107
,,1,1970-01-01T01:00:00Z,m,1,f,0.18038761353721244
,,1,1970-01-01T02:00:00Z,m,1,f,0.23198629938985071
,,1,1970-01-01T03:00:00Z,m,1,f,0.4940776062344333
,,1,1970-01-01T04:00:00Z,m,1,f,0.5654050390735228
,,1,1970-01-01T05:00:00Z,m,1,f,0.3788291715942209
,,1,1970-01-01T06:00:00Z,m,1,f,0.39178743939497507
,,1,1970-01-01T07:00:00Z,m,1,f,0.573740997246541
,,1,1970-01-01T08:00:00Z,m,1,f,0.6171205083791419
,,1,1970-01-01T09:00:00Z,m,1,f,0.2562012267655005
,,1,1970-01-01T10:00:00Z,m,1,f,0.41301351982023743
,,1,1970-01-01T11:00:00Z,m,1,f,0.335808747696944
,,1,1970-01-01T12:00:00Z,m,1,f,0.25034171949067086
,,1,1970-01-01T13:00:00Z,m,1,f,0.9866289864317817
,,1,1970-01-01T14:00:00Z,m,1,f,0.42988399575215924
,,1,1970-01-01T15:00:00Z,m,1,f,0.02602624797587471
,,1,1970-01-01T16:00:00Z,m,1,f,0.9926232260423908
,,1,1970-01-01T17:00:00Z,m,1,f,0.9771153046566231
,,1,1970-01-01T18:00:00Z,m,1,f,0.5680196566957276
,,1,1970-01-01T19:00:00Z,m,1,f,0.01952645919207055
,,1,1970-01-01T20:00:00Z,m,1,f,0.3439692491089684
,,1,1970-01-01T21:00:00Z,m,1,f,0.15596143014601407
,,1,1970-01-01T22:00:00Z,m,1,f,0.7986983212658367
,,1,1970-01-01T23:00:00Z,m,1,f,0.31336565203700295
,,1,1970-01-02T00:00:00Z,m,1,f,0.6398281383647288
,,1,1970-01-02T01:00:00Z,m,1,f,0.14018673322595193
,,1,1970-01-02T02:00:00Z,m,1,f,0.2847409792344233
,,1,1970-01-02T03:00:00Z,m,1,f,0.4295460864480138
,,1,1970-01-02T04:00:00Z,m,1,f,0.9674016258565854
,,1,1970-01-02T05:00:00Z,m,1,f,0.108837862280129
,,1,1970-01-02T06:00:00Z,m,1,f,0.47129460971856907
,,1,1970-01-02T07:00:00Z,m,1,f,0.9175708860682784
,,1,1970-01-02T08:00:00Z,m,1,f,0.3383504562747057
,,1,1970-01-02T09:00:00Z,m,1,f,0.7176237840014899
,,1,1970-01-02T10:00:00Z,m,1,f,0.45631599181081023
,,1,1970-01-02T11:00:00Z,m,1,f,0.58210555704762
,,1,1970-01-02T12:00:00Z,m,1,f,0.44833346180841194
,,1,1970-01-02T13:00:00Z,m,1,f,0.847082665931482
,,1,1970-01-02T14:00:00Z,m,1,f,0.1032050849659337
,,1,1970-01-02T15:00:00Z,m,1,f,0.6342038875836871
,,1,1970-01-02T16:00:00Z,m,1,f,0.47157138392000586
,,1,1970-01-02T17:00:00Z,m,1,f,0.5939195811492147
,,1,1970-01-02T18:00:00Z,m,1,f,0.3907003938279841
,,1,1970-01-02T19:00:00Z,m,1,f,0.3737781066004461
,,1,1970-01-02T20:00:00Z,m,1,f,0.6059179847188622
,,1,1970-01-02T21:00:00Z,m,1,f,0.37459130316766875
,,1,1970-01-02T22:00:00Z,m,1,f,0.529020795101784
,,1,1970-01-02T23:00:00Z,m,1,f,0.5797965259387311
,,1,1970-01-03T00:00:00Z,m,1,f,0.4196060336001739
,,1,1970-01-03T01:00:00Z,m,1,f,0.4423826236661577
,,1,1970-01-03T02:00:00Z,m,1,f,0.7562185239602677
,,1,1970-01-03T03:00:00Z,m,1,f,0.29641000596052747
,,1,1970-01-03T04:00:00Z,m,1,f,0.5511866012217823
,,1,1970-01-03T05:00:00Z,m,1,f,0.477231168882557
,,1,1970-01-03T06:00:00Z,m,1,f,0.5783604476492074
,,1,1970-01-03T07:00:00Z,m,1,f,0.6087147255603924
,,1,1970-01-03T08:00:00Z,m,1,f,0.9779728651411874
,,1,1970-01-03T09:00:00Z,m,1,f,0.8559123961968673
,,1,1970-01-03T10:00:00Z,m,1,f,0.039322803759977897
,,1,1970-01-03T11:00:00Z,m,1,f,0.5107877963474311
,,1,1970-01-03T12:00:00Z,m,1,f,0.36939734036661503
,,1,1970-01-03T13:00:00Z,m,1,f,0.24036834333350818
,,1,1970-01-03T14:00:00Z,m,1,f,0.9041140297145132
,,1,1970-01-03T15:00:00Z,m,1,f,0.3088634061697057
,,1,1970-01-03T16:00:00Z,m,1,f,0.3391757217065211
,,1,1970-01-03T17:00:00Z,m,1,f,0.5709032014080667
,,1,1970-01-03T18:00:00Z,m,1,f,0.023692334151288443
,,1,1970-01-03T19:00:00Z,m,1,f,0.9283397254805887
,,1,1970-01-03T20:00:00Z,m,1,f,0.7897301020744532
,,1,1970-01-03T21:00:00Z,m,1,f,0.5499067643037981
,,1,1970-01-03T22:00:00Z,m,1,f,0.20359811467533634
,,1,1970-01-03T23:00:00Z,m,1,f,0.1946255400705282
,,1,1970-01-04T00:00:00Z,m,1,f,0.44702956746887096
,,1,1970-01-04T01:00:00Z,m,1,f,0.44634342940951505
,,1,1970-01-04T02:00:00Z,m,1,f,0.4462164964469759
,,1,1970-01-04T03:00:00Z,m,1,f,0.5245740015591633
,,1,1970-01-04T04:00:00Z,m,1,f,0.29252555227190247
,,1,1970-01-04T05:00:00Z,m,1,f,0.5137169576742285
,,1,1970-01-04T06:00:00Z,m,1,f,0.1624473579380766
,,1,1970-01-04T07:00:00Z,m,1,f,0.30153697909681254
,,1,1970-01-04T08:00:00Z,m,1,f,0.2324327035115191
,,1,1970-01-04T09:00:00Z,m,1,f,0.034393197916253775
,,1,1970-01-04T10:00:00Z,m,1,f,0.4336629996115634
,,1,1970-01-04T11:00:00Z,m,1,f,0.8790573703532555
,,1,1970-01-04T12:00:00Z,m,1,f,0.9016824143089478
,,1,1970-01-04T13:00:00Z,m,1,f,0.34003737969744235
,,1,1970-01-04T14:00:00Z,m,1,f,0.3848952908759773
,,1,1970-01-04T15:00:00Z,m,1,f,0.9951718603202089
,,1,1970-01-04T16:00:00Z,m,1,f,0.8567450174592717
,,1,1970-01-04T17:00:00Z,m,1,f,0.12389207874832112
,,1,1970-01-04T18:00:00Z,m,1,f,0.6712865769046611
,,1,1970-01-04T19:00:00Z,m,1,f,0.46454363710822305
,,1,1970-01-04T20:00:00Z,m,1,f,0.9625945392247928
,,1,1970-01-04T21:00:00Z,m,1,f,0.7535558804101941
,,1,1970-01-04T22:00:00Z,m,1,f,0.744281664085344
,,1,1970-01-04T23:00:00Z,m,1,f,0.6811372884190415
,,1,1970-01-05T00:00:00Z,m,1,f,0.46171144508557443
,,1,1970-01-05T01:00:00Z,m,1,f,0.7701860606472665
,,1,1970-01-05T02:00:00Z,m,1,f,0.25517367370396854
,,1,1970-01-05T03:00:00Z,m,1,f,0.5564394982112523
,,1,1970-01-05T04:00:00Z,m,1,f,0.18256039263141344
,,1,1970-01-05T05:00:00Z,m,1,f,0.08465044152492789
,,1,1970-01-05T06:00:00Z,m,1,f,0.04682876596739505
,,1,1970-01-05T07:00:00Z,m,1,f,0.5116535677666431
,,1,1970-01-05T08:00:00Z,m,1,f,0.26327513076438025
,,1,1970-01-05T09:00:00Z,m,1,f,0.8551637599549397
,,1,1970-01-05T10:00:00Z,m,1,f,0.04908769638903045
,,1,1970-01-05T11:00:00Z,m,1,f,0.6747954667852788
,,1,1970-01-05T12:00:00Z,m,1,f,0.6701210820394512
,,1,1970-01-05T13:00:00Z,m,1,f,0.6698146693971668
,,1,1970-01-05T14:00:00Z,m,1,f,0.32939712697857165
,,1,1970-01-05T15:00:00Z,m,1,f,0.788384711857412
,,1,1970-01-05T16:00:00Z,m,1,f,0.9435078647906675
,,1,1970-01-05T17:00:00Z,m,1,f,0.05526759807741008
,,1,1970-01-05T18:00:00Z,m,1,f,0.3040576381882256
,,1,1970-01-05T19:00:00Z,m,1,f,0.13057573237533082
,,1,1970-01-05T20:00:00Z,m,1,f,0.438829781443743
,,1,1970-01-05T21:00:00Z,m,1,f,0.16639381298657024
,,1,1970-01-05T22:00:00Z,m,1,f,0.17817868556539768
,,1,1970-01-05T23:00:00Z,m,1,f,0.37006948631938175
,,1,1970-01-06T00:00:00Z,m,1,f,0.7711386953356921
,,1,1970-01-06T01:00:00Z,m,1,f,0.37364593618845465
,,1,1970-01-06T02:00:00Z,m,1,f,0.9285996064937719
,,1,1970-01-06T03:00:00Z,m,1,f,0.8685918613936688
,,1,1970-01-06T04:00:00Z,m,1,f,0.049757835180659744
,,1,1970-01-06T05:00:00Z,m,1,f,0.3562051567466768
,,1,1970-01-06T06:00:00Z,m,1,f,0.9028928456702144
,,1,1970-01-06T07:00:00Z,m,1,f,0.45412719022597203
,,1,1970-01-06T08:00:00Z,m,1,f,0.5210991958721604
,,1,1970-01-06T09:00:00Z,m,1,f,0.5013716125947244
,,1,1970-01-06T10:00:00Z,m,1,f,0.7798859934672562
,,1,1970-01-06T11:00:00Z,m,1,f,0.20777334301449937
,,1,1970-01-06T12:00:00Z,m,1,f,0.12979889080684515
,,1,1970-01-06T13:00:00Z,m,1,f,0.6713165183217583
,,1,1970-01-06T14:00:00Z,m,1,f,0.5267649385791876
,,1,1970-01-06T15:00:00Z,m,1,f,0.2766996970172108
,,1,1970-01-06T16:00:00Z,m,1,f,0.837561303602128
,,1,1970-01-06T17:00:00Z,m,1,f,0.10692091027423688
,,1,1970-01-06T18:00:00Z,m,1,f,0.16161417900026617
,,1,1970-01-06T19:00:00Z,m,1,f,0.7596615857389895
,,1,1970-01-06T20:00:00Z,m,1,f,0.9033476318497203
,,1,1970-01-06T21:00:00Z,m,1,f,0.9281794553091864
,,1,1970-01-06T22:00:00Z,m,1,f,0.7691815845690406
,,1,1970-01-06T23:00:00Z,m,1,f,0.5713941284458292
,,1,1970-01-07T00:00:00Z,m,1,f,0.8319045908167892
,,1,1970-01-07T01:00:00Z,m,1,f,0.5839200214729727
,,1,1970-01-07T02:00:00Z,m,1,f,0.5597883274306116
,,1,1970-01-07T03:00:00Z,m,1,f,0.8448107197504592
,,1,1970-01-07T04:00:00Z,m,1,f,0.39141999130543037
,,1,1970-01-07T05:00:00Z,m,1,f,0.3151057211763145
,,1,1970-01-07T06:00:00Z,m,1,f,0.3812489036241129
,,1,1970-01-07T07:00:00Z,m,1,f,0.03893545284960627
,,1,1970-01-07T08:00:00Z,m,1,f,0.513934438417237
,,1,1970-01-07T09:00:00Z,m,1,f,0.07387412770693513
,,1,1970-01-07T10:00:00Z,m,1,f,0.16131994851623296
,,1,1970-01-07T11:00:00Z,m,1,f,0.8524873225734262
,,1,1970-01-07T12:00:00Z,m,1,f,0.7108229805824855
,,1,1970-01-07T13:00:00Z,m,1,f,0.4087372331379091
,,1,1970-01-07T14:00:00Z,m,1,f,0.5408493060971712
,,1,1970-01-07T15:00:00Z,m,1,f,0.8752116934130074
,,1,1970-01-07T16:00:00Z,m,1,f,0.9569196248412628
,,1,1970-01-07T17:00:00Z,m,1,f,0.5206668595695829
,,1,1970-01-07T18:00:00Z,m,1,f,0.012847952493292788
,,1,1970-01-07T19:00:00Z,m,1,f,0.7155605509853933
,,1,1970-01-07T20:00:00Z,m,1,f,0.8293273149090988
,,1,1970-01-07T21:00:00Z,m,1,f,0.38705272903958904
,,1,1970-01-07T22:00:00Z,m,1,f,0.5459991408731746
,,1,1970-01-07T23:00:00Z,m,1,f,0.7066840478612406
"
outData =
    "
#datatype,string,long,dateTime:RFC3339,string,string,double
#group,false,false,false,true,true,false
#default,0,,,,,
,result,table,time,_measurement,t0,cumulative_sum
,,0,1970-01-01T00:00:00Z,m,0,0.19434194999233168
,,0,1970-01-01T01:00:00Z,m,0,0.5502117115340306
,,0,1970-01-01T02:00:00Z,m,0,1.4511048234394535
,,0,1970-01-01T03:00:00Z,m,0,2.097255422004095
,,0,1970-01-01T04:00:00Z,m,0,2.2312776833597288
,,0,1970-01-01T05:00:00Z,m,0,2.536369972964114
,,0,1970-01-01T06:00:00Z,m,0,2.704347873011682
,,0,1970-01-01T07:00:00Z,m,0,3.3903379491205223
,,0,1970-01-01T08:00:00Z,m,0,3.771675182555195
,,0,1970-01-01T09:00:00Z,m,0,4.149073190575701
,,0,1970-01-01T10:00:00Z,m,0,4.416094703170296
,,0,1970-01-01T11:00:00Z,m,0,4.614667435527389
,,0,1970-01-01T12:00:00Z,m,0,5.407308744598822
,,0,1970-01-01T13:00:00Z,m,0,6.256152375910654
,,0,1970-01-01T14:00:00Z,m,0,6.452181719489372
,,0,1970-01-01T15:00:00Z,m,0,6.724229136279894
,,0,1970-01-01T16:00:00Z,m,0,7.32873478622085
,,0,1970-01-01T17:00:00Z,m,0,7.54381822102341
,,0,1970-01-01T18:00:00Z,m,0,7.81507274632513
,,0,1970-01-01T19:00:00Z,m,0,8.042354660643586
,,0,1970-01-01T20:00:00Z,m,0,8.865602839374189
,,0,1970-01-01T21:00:00Z,m,0,9.837808299980264
,,0,1970-01-01T22:00:00Z,m,0,10.771102598282045
,,0,1970-01-01T23:00:00Z,m,0,10.780807403324367
,,0,1970-01-02T00:00:00Z,m,0,11.24228501844288
,,0,1970-01-02T01:00:00Z,m,0,11.63957043278532
,,0,1970-01-02T02:00:00Z,m,0,11.663728215225056
,,0,1970-01-02T03:00:00Z,m,0,12.37116338553267
,,0,1970-01-02T04:00:00Z,m,0,12.95315330292682
,,0,1970-01-02T05:00:00Z,m,0,13.250643276008605
,,0,1970-01-02T06:00:00Z,m,0,13.61713323302884
,,0,1970-01-02T07:00:00Z,m,0,14.183795782969792
,,0,1970-01-02T08:00:00Z,m,0,14.443061656005012
,,0,1970-01-02T09:00:00Z,m,0,15.133782311016216
,,0,1970-01-02T10:00:00Z,m,0,15.852262439418936
,,0,1970-01-02T11:00:00Z,m,0,16.215366426371748
,,0,1970-01-02T12:00:00Z,m,0,17.154192247212052
,,0,1970-01-02T13:00:00Z,m,0,17.85765613186283
,,0,1970-01-02T14:00:00Z,m,0,18.429146455044876
,,0,1970-01-02T15:00:00Z,m,0,18.673636934858838
,,0,1970-01-02T16:00:00Z,m,0,18.815287310517277
,,0,1970-01-02T17:00:00Z,m,0,18.868798668978787
,,0,1970-01-02T18:00:00Z,m,0,19.213876782314408
,,0,1970-01-02T19:00:00Z,m,0,19.44641975713867
,,0,1970-01-02T20:00:00Z,m,0,19.600588269864083
,,0,1970-01-02T21:00:00Z,m,0,20.529299644386946
,,0,1970-01-02T22:00:00Z,m,0,21.375740247028
,,0,1970-01-02T23:00:00Z,m,0,22.15436396260722
,,0,1970-01-03T00:00:00Z,m,0,22.87662698999149
,,0,1970-01-03T01:00:00Z,m,0,23.446912641805948
,,0,1970-01-03T02:00:00Z,m,0,23.89441470305999
,,0,1970-01-03T03:00:00Z,m,0,24.089238835365222
,,0,1970-01-03T04:00:00Z,m,0,24.234789841963533
,,0,1970-01-03T05:00:00Z,m,0,24.60632118873131
,,0,1970-01-03T06:00:00Z,m,0,24.76342243479113
,,0,1970-01-03T07:00:00Z,m,0,24.81457610404482
,,0,1970-01-03T08:00:00Z,m,0,25.310922839847866
,,0,1970-01-03T09:00:00Z,m,0,25.4094277643875
,,0,1970-01-03T10:00:00Z,m,0,25.48031305106398
,,0,1970-01-03T11:00:00Z,m,0,26.433908936349063
,,0,1970-01-03T12:00:00Z,m,0,27.38122126533224
,,0,1970-01-03T13:00:00Z,m,0,28.013420365200933
,,0,1970-01-03T14:00:00Z,m,0,28.544518926821898
,,0,1970-01-03T15:00:00Z,m,0,28.684621289675437
,,0,1970-01-03T16:00:00Z,m,0,29.19893242194478
,,0,1970-01-03T17:00:00Z,m,0,29.340887923295092
,,0,1970-01-03T18:00:00Z,m,0,29.375876094440358
,,0,1970-01-03T19:00:00Z,m,0,29.840518430553495
,,0,1970-01-03T20:00:00Z,m,0,30.568596016497587
,,0,1970-01-03T21:00:00Z,m,0,31.52911834948428
,,0,1970-01-03T22:00:00Z,m,0,32.158585496846946
,,0,1970-01-03T23:00:00Z,m,0,32.25535036631466
,,0,1970-01-04T00:00:00Z,m,0,32.740012856940254
,,0,1970-01-04T01:00:00Z,m,0,33.64002801986436
,,0,1970-01-04T02:00:00Z,m,0,34.45878007802953
,,0,1970-01-04T03:00:00Z,m,0,35.09442804535487
,,0,1970-01-04T04:00:00Z,m,0,36.01165730224184
,,0,1970-01-04T05:00:00Z,m,0,36.270371438098586
,,0,1970-01-04T06:00:00Z,m,0,37.20440163920558
,,0,1970-01-04T07:00:00Z,m,0,37.83443179136016
,,0,1970-01-04T08:00:00Z,m,0,38.82430138090735
,,0,1970-01-04T09:00:00Z,m,0,39.48195466594223
,,0,1970-01-04T10:00:00Z,m,0,39.591550040503265
,,0,1970-01-04T11:00:00Z,m,0,39.79869720714972
,,0,1970-01-04T12:00:00Z,m,0,40.292480397768976
,,0,1970-01-04T13:00:00Z,m,0,40.616943419910065
,,0,1970-01-04T14:00:00Z,m,0,40.75950545364327
,,0,1970-01-04T15:00:00Z,m,0,41.13434317452579
,,0,1970-01-04T16:00:00Z,m,0,42.072955536678165
,,0,1970-01-04T17:00:00Z,m,0,42.367399466825574
,,0,1970-01-04T18:00:00Z,m,0,43.17495875624241
,,0,1970-01-04T19:00:00Z,m,0,43.98807709756972
,,0,1970-01-04T20:00:00Z,m,0,44.59376461201288
,,0,1970-01-04T21:00:00Z,m,0,45.14516673576493
,,0,1970-01-04T22:00:00Z,m,0,45.43561849190662
,,0,1970-01-04T23:00:00Z,m,0,46.212996697267116
,,0,1970-01-05T00:00:00Z,m,0,46.35206998228008
,,0,1970-01-05T01:00:00Z,m,0,46.72081810255463
,,0,1970-01-05T02:00:00Z,m,0,47.57053144714934
,,0,1970-01-05T03:00:00Z,m,0,47.85475961443108
,,0,1970-01-05T04:00:00Z,m,0,48.43987830870233
,,0,1970-01-05T05:00:00Z,m,0,48.71534776518658
,,0,1970-01-05T06:00:00Z,m,0,48.75080316212925
,,0,1970-01-05T07:00:00Z,m,0,49.16142405505885
,,0,1970-01-05T08:00:00Z,m,0,49.52944981924283
,,0,1970-01-05T09:00:00Z,m,0,50.2778976036069
,,0,1970-01-05T10:00:00Z,m,0,50.49759214152938
,,0,1970-01-05T11:00:00Z,m,0,51.23533310416766
,,0,1970-01-05T12:00:00Z,m,0,51.66937398633295
,,0,1970-01-05T13:00:00Z,m,0,51.71095183464651
,,0,1970-01-05T14:00:00Z,m,0,52.611484281991075
,,0,1970-01-05T15:00:00Z,m,0,53.23579053128648
,,0,1970-01-05T16:00:00Z,m,0,53.64961800350353
,,0,1970-01-05T17:00:00Z,m,0,54.305614135482955
,,0,1970-01-05T18:00:00Z,m,0,54.40014143750177
,,0,1970-01-05T19:00:00Z,m,0,54.75222019214466
,,0,1970-01-05T20:00:00Z,m,0,55.22222309397733
,,0,1970-01-05T21:00:00Z,m,0,55.35606317895453
,,0,1970-01-05T22:00:00Z,m,0,55.61031270896288
,,0,1970-01-05T23:00:00Z,m,0,55.65388682478966
,,0,1970-01-06T00:00:00Z,m,0,55.92696390981365
,,0,1970-01-06T01:00:00Z,m,0,56.00043110050868
,,0,1970-01-06T02:00:00Z,m,0,56.193399801587056
,,0,1970-01-06T03:00:00Z,m,0,57.04846996859816
,,0,1970-01-06T04:00:00Z,m,0,57.949997967936085
,,0,1970-01-06T05:00:00Z,m,0,58.71813092772145
,,0,1970-01-06T06:00:00Z,m,0,58.85271675733672
,,0,1970-01-06T07:00:00Z,m,0,59.35531316057092
,,0,1970-01-06T08:00:00Z,m,0,60.321374275590806
,,0,1970-01-06T09:00:00Z,m,0,61.062049910604024
,,0,1970-01-06T10:00:00Z,m,0,61.54450314462472
,,0,1970-01-06T11:00:00Z,m,0,62.08418981248373
,,0,1970-01-06T12:00:00Z,m,0,62.324757684408326
,,0,1970-01-06T13:00:00Z,m,0,62.87210727439746
,,0,1970-01-06T14:00:00Z,m,0,63.86605602639549
,,0,1970-01-06T15:00:00Z,m,0,64.63786467179935
,,0,1970-01-06T16:00:00Z,m,0,65.01078785809091
,,0,1970-01-06T17:00:00Z,m,0,65.98900448618066
,,0,1970-01-06T18:00:00Z,m,0,66.29310950116337
,,0,1970-01-06T19:00:00Z,m,0,66.65604475882448
,,0,1970-01-06T20:00:00Z,m,0,67.11278369580661
,,0,1970-01-06T21:00:00Z,m,0,67.54165839620606
,,0,1970-01-06T22:00:00Z,m,0,67.96430284022401
,,0,1970-01-06T23:00:00Z,m,0,68.27049376734182
,,0,1970-01-07T00:00:00Z,m,0,68.93862288491061
,,0,1970-01-07T01:00:00Z,m,0,69.48803372698875
,,0,1970-01-07T02:00:00Z,m,0,69.80582967002523
,,0,1970-01-07T03:00:00Z,m,0,70.03085670714789
,,0,1970-01-07T04:00:00Z,m,0,70.06583817562658
,,0,1970-01-07T05:00:00Z,m,0,70.22723213438681
,,0,1970-01-07T06:00:00Z,m,0,70.86076402993893
,,0,1970-01-07T07:00:00Z,m,0,71.44626077530116
,,0,1970-01-07T08:00:00Z,m,0,71.87641891895679
,,0,1970-01-07T09:00:00Z,m,0,71.94857374543777
,,0,1970-01-07T10:00:00Z,m,0,72.0420578752723
,,0,1970-01-07T11:00:00Z,m,0,72.94443722996388
,,0,1970-01-07T12:00:00Z,m,0,73.84998235925006
,,0,1970-01-07T13:00:00Z,m,0,74.17802777366649
,,0,1970-01-07T14:00:00Z,m,0,74.23700246129805
,,0,1970-01-07T15:00:00Z,m,0,74.60563636396598
,,0,1970-01-07T16:00:00Z,m,0,75.36035376156504
,,0,1970-01-07T17:00:00Z,m,0,75.81820128770799
,,0,1970-01-07T18:00:00Z,m,0,76.3220332931636
,,0,1970-01-07T19:00:00Z,m,0,76.79261474316948
,,0,1970-01-07T20:00:00Z,m,0,77.32600507490261
,,0,1970-01-07T21:00:00Z,m,0,77.48085593633222
,,0,1970-01-07T22:00:00Z,m,0,78.16462404171915
,,0,1970-01-07T23:00:00Z,m,0,79.07281937990595
,,1,1970-01-01T00:00:00Z,m,1,0.15129694889144107
,,1,1970-01-01T01:00:00Z,m,1,0.3316845624286535
,,1,1970-01-01T02:00:00Z,m,1,0.5636708618185042
,,1,1970-01-01T03:00:00Z,m,1,1.0577484680529374
,,1,1970-01-01T04:00:00Z,m,1,1.6231535071264602
,,1,1970-01-01T05:00:00Z,m,1,2.0019826787206814
,,1,1970-01-01T06:00:00Z,m,1,2.3937701181156563
,,1,1970-01-01T07:00:00Z,m,1,2.967511115362197
,,1,1970-01-01T08:00:00Z,m,1,3.584631623741339
,,1,1970-01-01T09:00:00Z,m,1,3.8408328505068394
,,1,1970-01-01T10:00:00Z,m,1,4.253846370327077
,,1,1970-01-01T11:00:00Z,m,1,4.589655118024021
,,1,1970-01-01T12:00:00Z,m,1,4.8399968375146925
,,1,1970-01-01T13:00:00Z,m,1,5.826625823946474
,,1,1970-01-01T14:00:00Z,m,1,6.256509819698633
,,1,1970-01-01T15:00:00Z,m,1,6.282536067674507
,,1,1970-01-01T16:00:00Z,m,1,7.275159293716898
,,1,1970-01-01T17:00:00Z,m,1,8.252274598373521
,,1,1970-01-01T18:00:00Z,m,1,8.82029425506925
,,1,1970-01-01T19:00:00Z,m,1,8.83982071426132
,,1,1970-01-01T20:00:00Z,m,1,9.183789963370288
,,1,1970-01-01T21:00:00Z,m,1,9.339751393516302
,,1,1970-01-01T22:00:00Z,m,1,10.138449714782139
,,1,1970-01-01T23:00:00Z,m,1,10.451815366819142
,,1,1970-01-02T00:00:00Z,m,1,11.091643505183871
,,1,1970-01-02T01:00:00Z,m,1,11.231830238409824
,,1,1970-01-02T02:00:00Z,m,1,11.516571217644247
,,1,1970-01-02T03:00:00Z,m,1,11.94611730409226
,,1,1970-01-02T04:00:00Z,m,1,12.913518929948845
,,1,1970-01-02T05:00:00Z,m,1,13.022356792228974
,,1,1970-01-02T06:00:00Z,m,1,13.493651401947544
,,1,1970-01-02T07:00:00Z,m,1,14.411222288015821
,,1,1970-01-02T08:00:00Z,m,1,14.749572744290527
,,1,1970-01-02T09:00:00Z,m,1,15.467196528292016
,,1,1970-01-02T10:00:00Z,m,1,15.923512520102825
,,1,1970-01-02T11:00:00Z,m,1,16.505618077150444
,,1,1970-01-02T12:00:00Z,m,1,16.953951538958858
,,1,1970-01-02T13:00:00Z,m,1,17.80103420489034
,,1,1970-01-02T14:00:00Z,m,1,17.90423928985627
,,1,1970-01-02T15:00:00Z,m,1,18.53844317743996
,,1,1970-01-02T16:00:00Z,m,1,19.010014561359963
,,1,1970-01-02T17:00:00Z,m,1,19.60393414250918
,,1,1970-01-02T18:00:00Z,m,1,19.994634536337163
,,1,1970-01-02T19:00:00Z,m,1,20.36841264293761
,,1,1970-01-02T20:00:00Z,m,1,20.97433062765647
,,1,1970-01-02T21:00:00Z,m,1,21.34892193082414
,,1,1970-01-02T22:00:00Z,m,1,21.877942725925923
,,1,1970-01-02T23:00:00Z,m,1,22.457739251864655
,,1,1970-01-03T00:00:00Z,m,1,22.87734528546483
,,1,1970-01-03T01:00:00Z,m,1,23.31972790913099
,,1,1970-01-03T02:00:00Z,m,1,24.075946433091257
,,1,1970-01-03T03:00:00Z,m,1,24.372356439051785
,,1,1970-01-03T04:00:00Z,m,1,24.923543040273568
,,1,1970-01-03T05:00:00Z,m,1,25.400774209156125
,,1,1970-01-03T06:00:00Z,m,1,25.979134656805332
,,1,1970-01-03T07:00:00Z,m,1,26.587849382365725
,,1,1970-01-03T08:00:00Z,m,1,27.56582224750691
,,1,1970-01-03T09:00:00Z,m,1,28.42173464370378
,,1,1970-01-03T10:00:00Z,m,1,28.461057447463755
,,1,1970-01-03T11:00:00Z,m,1,28.971845243811185
,,1,1970-01-03T12:00:00Z,m,1,29.3412425841778
,,1,1970-01-03T13:00:00Z,m,1,29.581610927511306
,,1,1970-01-03T14:00:00Z,m,1,30.48572495722582
,,1,1970-01-03T15:00:00Z,m,1,30.794588363395526
,,1,1970-01-03T16:00:00Z,m,1,31.133764085102047
,,1,1970-01-03T17:00:00Z,m,1,31.704667286510116
,,1,1970-01-03T18:00:00Z,m,1,31.728359620661404
,,1,1970-01-03T19:00:00Z,m,1,32.65669934614199
,,1,1970-01-03T20:00:00Z,m,1,33.44642944821644
,,1,1970-01-03T21:00:00Z,m,1,33.99633621252024
,,1,1970-01-03T22:00:00Z,m,1,34.19993432719558
,,1,1970-01-03T23:00:00Z,m,1,34.3945598672661
,,1,1970-01-04T00:00:00Z,m,1,34.84158943473498
,,1,1970-01-04T01:00:00Z,m,1,35.287932864144494
,,1,1970-01-04T02:00:00Z,m,1,35.73414936059147
,,1,1970-01-04T03:00:00Z,m,1,36.25872336215064
,,1,1970-01-04T04:00:00Z,m,1,36.551248914422544
,,1,1970-01-04T05:00:00Z,m,1,37.06496587209677
,,1,1970-01-04T06:00:00Z,m,1,37.22741323003485
,,1,1970-01-04T07:00:00Z,m,1,37.52895020913166
,,1,1970-01-04T08:00:00Z,m,1,37.76138291264318
,,1,1970-01-04T09:00:00Z,m,1,37.79577611055943
,,1,1970-01-04T10:00:00Z,m,1,38.22943911017099
,,1,1970-01-04T11:00:00Z,m,1,39.10849648052425
,,1,1970-01-04T12:00:00Z,m,1,40.0101788948332
,,1,1970-01-04T13:00:00Z,m,1,40.350216274530645
,,1,1970-01-04T14:00:00Z,m,1,40.73511156540662
,,1,1970-01-04T15:00:00Z,m,1,41.730283425726824
,,1,1970-01-04T16:00:00Z,m,1,42.5870284431861
,,1,1970-01-04T17:00:00Z,m,1,42.71092052193442
,,1,1970-01-04T18:00:00Z,m,1,43.38220709883908
,,1,1970-01-04T19:00:00Z,m,1,43.8467507359473
,,1,1970-01-04T20:00:00Z,m,1,44.8093452751721
,,1,1970-01-04T21:00:00Z,m,1,45.562901155582296
,,1,1970-01-04T22:00:00Z,m,1,46.30718281966764
,,1,1970-01-04T23:00:00Z,m,1,46.98832010808668
,,1,1970-01-05T00:00:00Z,m,1,47.45003155317226
,,1,1970-01-05T01:00:00Z,m,1,48.22021761381953
,,1,1970-01-05T02:00:00Z,m,1,48.4753912875235
,,1,1970-01-05T03:00:00Z,m,1,49.031830785734755
,,1,1970-01-05T04:00:00Z,m,1,49.21439117836617
,,1,1970-01-05T05:00:00Z,m,1,49.2990416198911
,,1,1970-01-05T06:00:00Z,m,1,49.3458703858585
,,1,1970-01-05T07:00:00Z,m,1,49.85752395362514
,,1,1970-01-05T08:00:00Z,m,1,50.12079908438952
,,1,1970-01-05T09:00:00Z,m,1,50.97596284434446
,,1,1970-01-05T10:00:00Z,m,1,51.02505054073349
,,1,1970-01-05T11:00:00Z,m,1,51.699846007518765
,,1,1970-01-05T12:00:00Z,m,1,52.369967089558216
,,1,1970-01-05T13:00:00Z,m,1,53.039781758955385
,,1,1970-01-05T14:00:00Z,m,1,53.369178885933955
,,1,1970-01-05T15:00:00Z,m,1,54.157563597791366
,,1,1970-01-05T16:00:00Z,m,1,55.101071462582034
,,1,1970-01-05T17:00:00Z,m,1,55.15633906065944
,,1,1970-01-05T18:00:00Z,m,1,55.46039669884767
,,1,1970-01-05T19:00:00Z,m,1,55.590972431223
,,1,1970-01-05T20:00:00Z,m,1,56.029802212666745
,,1,1970-01-05T21:00:00Z,m,1,56.196196025653315
,,1,1970-01-05T22:00:00Z,m,1,56.374374711218714
,,1,1970-01-05T23:00:00Z,m,1,56.744444197538094
,,1,1970-01-06T00:00:00Z,m,1,57.51558289287379
,,1,1970-01-06T01:00:00Z,m,1,57.88922882906224
,,1,1970-01-06T02:00:00Z,m,1,58.81782843555601
,,1,1970-01-06T03:00:00Z,m,1,59.68642029694968
,,1,1970-01-06T04:00:00Z,m,1,59.736178132130334
,,1,1970-01-06T05:00:00Z,m,1,60.09238328887701
,,1,1970-01-06T06:00:00Z,m,1,60.995276134547225
,,1,1970-01-06T07:00:00Z,m,1,61.4494033247732
,,1,1970-01-06T08:00:00Z,m,1,61.97050252064536
,,1,1970-01-06T09:00:00Z,m,1,62.471874133240085
,,1,1970-01-06T10:00:00Z,m,1,63.25176012670734
,,1,1970-01-06T11:00:00Z,m,1,63.45953346972184
,,1,1970-01-06T12:00:00Z,m,1,63.58933236052869
,,1,1970-01-06T13:00:00Z,m,1,64.26064887885045
,,1,1970-01-06T14:00:00Z,m,1,64.78741381742964
,,1,1970-01-06T15:00:00Z,m,1,65.06411351444684
,,1,1970-01-06T16:00:00Z,m,1,65.90167481804897
,,1,1970-01-06T17:00:00Z,m,1,66.00859572832321
,,1,1970-01-06T18:00:00Z,m,1,66.17020990732348
,,1,1970-01-06T19:00:00Z,m,1,66.92987149306248
,,1,1970-01-06T20:00:00Z,m,1,67.8332191249122
,,1,1970-01-06T21:00:00Z,m,1,68.7613985802214
,,1,1970-01-06T22:00:00Z,m,1,69.53058016479044
,,1,1970-01-06T23:00:00Z,m,1,70.10197429323627
,,1,1970-01-07T00:00:00Z,m,1,70.93387888405306
,,1,1970-01-07T01:00:00Z,m,1,71.51779890552604
,,1,1970-01-07T02:00:00Z,m,1,72.07758723295665
,,1,1970-01-07T03:00:00Z,m,1,72.9223979527071
,,1,1970-01-07T04:00:00Z,m,1,73.31381794401253
,,1,1970-01-07T05:00:00Z,m,1,73.62892366518884
,,1,1970-01-07T06:00:00Z,m,1,74.01017256881295
,,1,1970-01-07T07:00:00Z,m,1,74.04910802166255
,,1,1970-01-07T08:00:00Z,m,1,74.56304246007979
,,1,1970-01-07T09:00:00Z,m,1,74.63691658778671
,,1,1970-01-07T10:00:00Z,m,1,74.79823653630295
,,1,1970-01-07T11:00:00Z,m,1,75.65072385887638
,,1,1970-01-07T12:00:00Z,m,1,76.36154683945887
,,1,1970-01-07T13:00:00Z,m,1,76.77028407259678
,,1,1970-01-07T14:00:00Z,m,1,77.31113337869395
,,1,1970-01-07T15:00:00Z,m,1,78.18634507210696
,,1,1970-01-07T16:00:00Z,m,1,79.14326469694822
,,1,1970-01-07T17:00:00Z,m,1,79.66393155651781
,,1,1970-01-07T18:00:00Z,m,1,79.6767795090111
,,1,1970-01-07T19:00:00Z,m,1,80.39234005999649
,,1,1970-01-07T20:00:00Z,m,1,81.22166737490558
,,1,1970-01-07T21:00:00Z,m,1,81.60872010394517
,,1,1970-01-07T22:00:00Z,m,1,82.15471924481835
,,1,1970-01-07T23:00:00Z,m,1,82.8614032926796
"

testcase cumulative_sum {
    got =
        csv.from(csv: inData)
            |> testing.load()
            |> range(start: influxql.minTime, stop: influxql.maxTime)
            |> filter(fn: (r) => r._measurement == "m")
            |> filter(fn: (r) => r._field == "f")
            |> cumulativeSum()
            |> drop(columns: ["_start", "_stop", "_field"])
            |> rename(columns: {_time: "time", _value: "cumulative_sum"})
    want = csv.from(csv: outData)

    testing.diff(got, want)
}
