import 
  stint

# Acceptable roots for merkle root validation of incoming messages
const AcceptableRootWindowSize* = 5

# RLN membership key and index files path
const
  RlnCredentialsFilename* = "rlnCredentials.txt"
  
# inputs of the membership contract constructor
# TODO may be able to make these constants private and put them inside the waku_rln_relay_utils
const
  MembershipFee* = 1000000000000000.u256
  #  the current implementation of the rln lib supports a circuit for Merkle tree with depth 20
  MerkleTreeDepth* = 20
  EthClient* = "ws://127.0.0.1:8540"

const
  # the size of poseidon hash output in bits
  HashBitSize* = 256
  # the size of poseidon hash output as the number hex digits
  HashHexSize* = int(HashBitSize/4)


when defined(rlnzerokit):
  const
    # The relative folder where the circuit, proving and verification key for RLN can be found
    # Note that resources has to be compiled with respect to the above MerkleTreeDepth
    RlnResourceFolder* = "vendor/zerokit/rln/resources/tree_height_" & $MerkleTreeDepth & "/"
  
# temporary variables to test waku-rln-relay performance in the static group mode
const
  StaticGroupSize* = 100
  #  StaticGroupKeys is a static list of 100 membership keys in the form of (identity key, identity commitment)
  #  keys are created locally, using createMembershipList proc from waku_rln_relay_utils module, and the results are hardcoded in here
  #  this list is temporary and is created to test the performance of waku-rln-relay for the static groups
  #  in the later versions, this static hardcoded group will be replaced with a dynamic one
  
when defined(rln):
  const
    StaticGroupKeys* = @[("1754e80116f859952d343497fcbcafbeaa89ee79a01590c5659d531f5bd0a4e9", 
        "134ec3c055614df49366c5a7d9d497a43df3963439eefb2611ab00325b3a4db7"), (
        "2311a6596f06fcf1a140e4d2aae7047e007010ce36afbe1938e55752c2bfb227", 
        "2701fc7c513748cb838f289e186f141f66b98f506f47a8791e0496ff1ae52c52"), (
        "1dff8ec1abe4f3a9928f6e9d707a3190ba4394d393e35fc5674267e6aa2e3966", 
        "2aba77fb760a82bdb0efcc39e8eb505a41f1d0ec9f24fc431981c1485e23dce3"), (
        "0ed4c2d68e6664cf120be470389c267bfe652d054b01b80d230514b8eb2e46e7", 
        "2a21425cf4cf0c0fc259310b0123e4571ec88c2018be37a64e14345e96f07d72"), (
        "0450eb7d85db7487c68a01dc33072c48b01725a061652d3a0175704c8b52d81a", 
        "0822b60c2c17cbd68258e9e6b96b7d2b0926508fe79e2ada8457137775a7f35d"), (
        "00e7e86c5fec0c49336b4313eb4cf4970bacc318df941d871f8650fc3bf50faa", 
        "2768594ac3b97e0023dcd76668403cf74b03ce9aa23b47c0aeae05b9051d4230"), (
        "2443e28a18873e4405438142a87e4ef2298db578e45dc4c477b157eda6c04804", 
        "02b06a1a610f7b24c9a4a36e3c601ae68eb43f8e7c3628a0f52a97d804a7a15e"), (
        "0030668f19bb3e609b128f18cb4b0c32caba76c9a3f4e3ef9be611dddb6e6a4b", 
        "1ebde6f3193f1ce0d3ab39b8b1cea73ea4ac9c3b6834f073882cade885611d45"), (
        "2bcf2ce1e4b2fb88446aed5904d947fbc3dd80296d329656023fb35548a3fbc3", 
        "0e6a7bccf4eaa5532c41cb97b9074ada3b7856e233e68fad66a84e14864a6774"), (
        "05e4104c85681bf35eb23037cf872a33a53e9f1c24c6d7261c0f724ab9b8350c", 
        "2d08ba0d89b68d3ee16379cd41e8639b2f76ed9e297ce37bc19ed18a8ddf1569"), (
        "0999028058041c111795188d7a93063b3e7fc71a41c3c846ba95da7716020ba6", 
        "0fc941adf2e210865dcba6e1912c8b6e6eb2210fcd1707fdc6ce44cb2ed2fcbb"), (
        "0f563bcc1d2176235c613cf37b4dead2015ad7a37eb808b754e7fb662e664d2f", 
        "108820acff8c4963b65ea308d35feb5195c4821e57869f8b0293322c627e7fc6"), (
        "2ee26c5b01ae74aca3444e7242da07998b6e3df29c9a983b8d4cc196fa1a0ad9", 
        "2e2017c800ec4b1a3f469da66ea176e07bd9427604abb65272900add1b5b79f0"), (
        "1064fb1843470365b272bade45418bcfac1b4f27e504757710dac8894d76a0df", 
        "254e25ce3b6b98c1050c5419309f9cbed74ff0f2d9b6cfcc132fea33e8a88a9f"), (
        "12e7a5d4bfc1397b5294e32fe32135d7d422b96710ff6409a4536b3b019074e1", 
        "260ae876bf8f65cca680a78d024c93e4f63986d9a718286fa3144b0e3aa28f7a"), (
        "10845ab17088c0fda8951b9132b6f9a1fa7f21e800111bdbdd735307d128937a", 
        "22c1e3958316a8fe73eba7e61fd3b27db1e718fe198c097348b946c070aeb294"), (
        "1d16525cb0f78c0431f1c4d331a4b539a5be9d37b38aa851bfa57d44b19b31ce", 
        "2cf26f5c78cef9a552c2a807e8a7bb6ab04b54cf3257ff9fbc1ba5b84a26facd"), (
        "13d38f4469f75248e5c51f0020176a93b47ce72b47c43fa09cefcbbf038581d3", 
        "0b9c940a6487299c8a3374cf93520c724a8914e50d67a5756c9706d9ab9227e7"), (
        "1e90c015c440cf0487c8b874434d8d9362ed3a2dd10226b66e736084118d9b4f", 
        "1cf0a5922f52d0b2562e318b8724490b0a950402fe53104a9231de8a58e4cb2e"), (
        "05f9e72ed636a4af8aaf80acf87d5fdfcd4900f1cec8dc3e63f9da6ad99fb539", 
        "00bf64c7a42e1d5948bcd6b7f7da149af38f30969a6a76c25fa9f89d977a4fb9"), (
        "22c30094233a91a20d739fe91d95bbb8eaaf2b8537821c362b185d99250dcb73", 
        "06461491db94fa4d47282d57765bbcab26d84414747b6654cd6b6b44e4e604da"), (
        "095087b0756edc2c779d57e805ec03fb465c1258bc99278bbba5bb833b425327", 
        "0db33f6fdf6ea729036b316a172d16716f41062d69a3313429e720ec100004ee"), (
        "1b36e58cbda349ee1405b2aa9093bb28de59074a14515b27e65c35679bec73cb", 
        "0d8ed588232e3dc3b97da1f1cae8d58d007bb6dd1b2498b3031ffe3eade2c6c7"), (
        "1b372ea1e7d8808a819d6c7f2f39325d2a684602d826e9ed1356fef3d986b3bd", 
        "0209844720b22d3e5608c8ce99cbd0113c6b919987b19dcb72ef22f4748cd421"), (
        "09a8e4fc8a5f88a4d3d6a737987a73ffce6a0f33fac1469044341034fefcf260", 
        "0c379326bd364e5633d0b77c76a2ea7b3d9105171fb25a1b5127419e6ff2c8e4"), (
        "0b18d1e647544e9ce084e1e7baf7c23406784315d966aec12149c4b54fd62312", 
        "06a45e4705ac7b779a401ccfc912ed03ac9676aab222bac53435fc1447b80a29"), (
        "2f2bfeee70344624046ccad18697e2f5a5c7433b7fbb16d38022c41633599cb7", 
        "25f0bf499ce5b26ab61146d0348e0dee4e5500dd713e40ab324d4c57c94ae4f4"), (
        "149cdb177594cc519b2820366e28a73dc414afe1320460b65c65be9e668f54e6", 
        "0249958294df9248fe37ae56685e47cd184010523f699a38cb1d4a96e361e2ac"), (
        "00f10851bfd49611e19097cc17f09dfd0a199bf7e0092284f464939c4054be81", 
        "231b39567453e6194bb5fe4f3d91ff28308108d66f2bf165e00327422eb286d9"), (
        "05f32eddbce7efe611c4397e773b8302deed6acf00d97aaf1b9d54b4d3f00f94", 
        "129494c8e268671b4de666967c287b82faf31605de65b3db7fb4756e8abb72d6"), (
        "0a8cdce6703196a77b9f8d0b201372fb086df87d164cccb336c8c8a10a30feb4", 
        "202015161c8f8f8132d40c95be25126d0596cf025c95d19f5c3f7f86a9b67d5f"), (
        "2a524092c44e12ba4420bd1642bf7871e40ae4ca7d207082b78c73b3bda2342c", 
        "153e677112e9594875fd6ce4473f2d74c3c92ecc10354932ab35d7d7780c498c"), (
        "2dfae9b260de4cc77d145084694cfe851ee0999bbbf90bd4172df93f7a8503fc", 
        "0908e0d70b8e7cd3ae40346615b2742c9fefa24502bca5bb42bcababcd2aa2c0"), (
        "239298ea28c9ecf0b63725e00b2b83aca90d449abb908e78033bc6356aa967a2", 
        "2d1785c3ef21a2c893edb66d3c0810af52932ef37d3b30ca99e9bca5cdea6c63"), (
        "09a21707464456896bbec9f849c423c5f8916cde32474cac9d7a66c1a2154ece", 
        "12bdc6dc385440fdc5e7afdbdba6ed9a46bd732829309b51d2360bf423655cd5"), (
        "062341fa151ad9d6e97fa1cf844d3009543701b7596c398c00cbe3a4de7c614c", 
        "192836c5846b8464f3dd4ec4ec6fb3b08d73dfe9d8f2699ca31854c3a921dca6"), (
        "06c84c54ced6dc86c867bfbb4e3870e32bb904a3d12ec61cb1f9943d2baa338c", 
        "2c1d40f1a17ce628cdd709dd042a0cc56efd88a99467a38bb5708cabb1a2ac7c"), (
        "28a202c8f544970a453068e6badbbba3b011e7f06c499af8dc6c7e00f4c86f1b", 
        "1824c19235314ac12aed38238cadfd3e9597fb1e00920c9ab9fe32bd7894b7c3"), (
        "06dbd49b8330f96d880c7cdef72e16a2ef0a96f0bd31fee5b1f1e03ee837680c", 
        "2bf5b861ea14b591bd0ef028a5921eabb7ebd34c01fb870f3fb11a15b567268b"), (
        "270c2532ca6de9a54f9f47d1a7ad8e4de3a23204b1d84445c39735966080a38d", 
        "2ef4080d8fe149320c185ef80f3e23d4b0a6f2b04d6deb2f776f8e5a1125f57b"), (
        "0d34c89be7770c9493d2df6d93df0b3878b7439efcf152fc119d6a5fd8c6b050", 
        "118840ba5709bc2baffe1414bee3d9e7293bb3d78424031e34ef81de97e2b9bb"), (
        "0851726d44987f5faad3cb3186d820ccf3054f8dbde4a68bff32cf20add38f6e", 
        "10521f381a50c78d7a04872001d7535b17f20153209a041204043b610474fea9"), (
        "2820de5043c0c4d10365be30eb23ac058d19a1d2ad6d0be8f7fe9cd632bb91c2", 
        "22d451429f862f9ce71a30d3020caaef9e3193c792662af75195849da08c4ff4"), (
        "1d6888b239d40d68719b539eadc949466ac5de31def0879a811f10212e4c6d11", 
        "0c81dd6f090634f6ec356fd557d3d51761fb8a8de3e3d63be60b39055ef64d9f"), (
        "0cb0dba2a97f353a90f8448713f8aa2cb1e92d854a0823e6169a296037ed1318", 
        "0f3a65bfb8ff5ce76880da9ddd415e428ac807f851b8509f48bc07cdccaa7bf3"), (
        "1eb0e5c3d7a2d95204eb161b41bcf8740a66b08bade7171cdb89bb2cd7625e54", 
        "19ae9f92e872f22aaa50e40686c3852d350af871731d95b1c791b0863ac9dd96"), (
        "1415cd7a3beaaa401a433195f2db28bdad7cff29ccaea61ec297464741595d0f", 
        "25a5b2db7048df069d0463d4a8834aa3e4d2d725611b9cb11fb84dabf30f3de8"), (
        "1c380ee1d11e957424c9f9eef2aee629f1600a842a4cadd5f99280f4c15b6052", 
        "0c1926f4c88aa09b9f7aa7d8e1afcd6f05e4c7bf9ef272c88506b2b8aff32d22"), (
        "0b2f464574212657197698090da1c2a2c3a4bb14154c17d01af1e957eecde8ee", 
        "240adbe97b27474995d130f5579afb14c722b5098c22ae4b1533c99a79e500a0"), (
        "1a494d7cdc7334d15b6ae39c9cb44a2982d42ac9ffdc86810f371639dc047d8c", 
        "19ebc99a0625cd499132c6bf67db3ace370333364f44b315cefb2ed8bc358e78"), (
        "271fa65913ec18801e3e5869eba5bcccce5aa48da730eb827fbbda9e0f724a00", 
        "168eb1fe167e11f5d4f396029e79da6123b25938d3ac49a66980ea4bd619d3e3"), (
        "2fb2efd125cc02eec6dcf7dcc6adf0cbee17636d2d5b5a79377ede7c1d6f7138", 
        "01131ac227d77ca684adee2b6555eaa20196e4e63da2e02b5f48c1cfd029c295"), (
        "136c6f48c73cd54c8e72698730659abfa4afdd0abb2a8171d0f3999ea4c7ca22", 
        "00fd7a1f068d69bde38a992451f2a293abcacbb976d720bc6499800606b9e5a2"), (
        "0fe2e20e36747bb834a0867add2a60395409f12fb7587378a4ba731fa4c70951", 
        "0cf9bd35d34de3c0d2dc8ff09d256702a46e8f8f42b9515a8b82ed33203e1ba3"), (
        "1c470a109f5aa434557259b64eab5b8814edd6d6c385705635a1290f47877a95", 
        "1330fa967506fa60e0cbcf871e73053d2313a3355e4033fa875a2d28df05308f"), (
        "2e3dd0e3134de90a4a28e9031041d23697b25c961c847cdc93b2c20676d5dae0", 
        "27ba6aa6ce8db9ed6acb28657020ad8bcecaeb512429cc0d0317b6f03e644305"), (
        "09da242f70ba7f2d3f5c7c93351140332170bbee2bf1b3156b5ba5c83809f1f1", 
        "1d09919e24cc30b288bf54368c8764401e567f1a7350d5217410d55a8a2a86dc"), (
        "116977ae96ae633647e6cdd1b988bdb1b2c73999bdd678572370998cd708bc4b", 
        "1350c30b0511497e57885a223b576ab8eed3f4115051e8aab37f1ae39cbe8435"), (
        "1367d64194704d5fdabf008ed217c5ccc5eb6e25f5d823ca575729c9315b32c8", 
        "09f0da5356fcfe42f73e2740b7d8449b2118cb19556270c48504160309361fb8"), (
        "148aae61dbb4167903ba281e317fbf325760505ddb6ca5ef7958be2fe2b3a669", 
        "24699648af51b9912defd47ed90695d4f0b10c1556545720da673eeb00f8dd10"), (
        "01e4de198b62b492d54196c84ad5d019169a3a6c6879f92e9fb44b6d58e3a0c2", 
        "15d3022d4d41547f4bd2cf90ef10a9eec373f0b9a3d423f0f93ed1f677a63bbc"), (
        "052cc59fc19d36bd6f30df6ceb475e95be68bc2eafd760774537ff791b05895b", 
        "11bac4cdd46789ccbd849e2b0d6721af67c8077aa28e05f9e0adb25b9d2afe7b"), (
        "05416432bca14ab5eb32189cd8a1a054002429ad33699068bf23bc5cf345ac46", 
        "11bda5087d3250462d8840dd0d5159e3e42c6f8ff638b88a1b5a61d583e791e8"), (
        "23cd701c8cc4969f15eb7cdf400585cbe616f82209191c86af0cc4377b061e58", 
        "25fbd6073b49887a51c99f41d36a20c93aaab0ea21416fc3692320748cfa490d"), (
        "15367d2c2adde7c908b012f96fab7a8ebead4ec063d9fa142ea2452bbab47ebb", 
        "2531e38c637ae2eb941b40b2c7f6eef0f0658275fa728050821ff5cec8d08e75"), (
        "2807baf0d6905013a0ec665bda29d24eefbded4da1f5d1942b674f90c93c8fa0", 
        "0a70bb3afb67ad6dd6a3da20d1bd2d29fcc7e92289d45ba1cf41d29523952c54"), (
        "08bdfd28c75e42dfcf860da9306a8f2e3e701f439bf35c5fbd4194445cac5b10", 
        "0d3e710bf7cf81faea828cc31e86a4e6f19bc8e311719a3298fb56d5f10692b5"), (
        "1359d98332177364920c993cff41a8ea2f0d2c409afa9eb9da34a2aedf2edf45", 
        "277513cbe4ece6e3df0284166ebd27c82d8bf1f5143a374905a5c322f98c00db"), (
        "14ebf13977acdd66b327fcd25e198c07cc99e5b70744e8855bef157c43d68d48", 
        "17bef44e79d4cb92fe18278a3e71c60fa17b10df0a547e4e4677c6557f884804"), (
        "302a37a86e3ccbff42ebbe24ae4eaad92416a9ef09d5b55ee104358f6997e63f", 
        "1781abe1087e7d834a6452e43ddf0a5d1c7c9b3c51f7583a89c1c6e728cb1c44"), (
        "042e3cf71e65ef512ddda40f88a68e33bf472781c6f175db744c26721280b59b", 
        "0eb24732c383df3473d146039d4356151ecbcf3f31b01f3f0bc338e880fdeee2"), (
        "11d91c5cca940d43e9d4cce22a60ef146481f2568650785b87fec467147ad3ba", 
        "1d59ad1bb34bfae22a7f12992132c9647b46311588c3daa93e2eedbacd2cc721"), (
        "0ded6352cbe2615a5ef63fbb81df7541459c0559fcabb185c1edbacc3722c795", 
        "0d9da073ec3a6e6316e9b502b2d6ab1fee0a2fda5dc7a9f75cac75478a724010"), (
        "2a5f7478603258a0ecf2026a5cf19ab399e9259b2a0bf795bc99d1f49a8b8e73", 
        "0dcaa540efb2836a05bdd94ab410b9dfef3c45df0789811d103ea00a96354800"), (
        "2ed1b60adba545f156ffe4380e88ec86b517b6d19786c0bf60fef286f4ca880d", 
        "1a2b7b8ffb6895003ceb414443fcdb534d3d2cb63505c584bc9552812393b1a7"), (
        "1f7903f37f81dc7d1a1df3d3867fa9dacf970373bf8eba0f59904d31fdf77ab3", 
        "03b7982eb26d8922279aaf3b5f2cdb291e124fa32d648427f997aece0ea89682"), (
        "0b6a36fe2f31cf88f53fb0cc98477b0b919d274ea1f5313411cba85130dd676b", 
        "129af8e6d724a95d162a40c4363df3b130cdb2e36dd6a0e43b790b3a54cc389c"), (
        "279f31fa071b1f4e83b56dbd1a9553fc22094614a6ab4db3d1b906e4404cfc72", 
        "020d4186d347cedebc7e96b479058e1d8b269b8a84e38aa7c447ba8104d5a4da"), (
        "00f00d0ddd55e78292d2e76e3e79c4012909a45850279f01cf3da2b2b25ccea4", 
        "26b2cd897a4da9fb6dcd83223d2793d0c2e2524dc3117958f35130d253947400"), (
        "214597ea586b9f544af091c6149769133a370611abfeab728eace81602df009e", 
        "27ef532cd34e56d76121c2f964849ed4947c2d97177ece58bbb82390fddb690e"), (
        "1be73dd5739e70d50082841b2bb6d7ac69b86dcf4dc0a7fe25f415638c551afe", 
        "2210b28ea59b7fa6afe29ea32456c54f0106e5c06ad7927080cb618dcc33cd66"), (
        "0a431af62dae6c7e9b5066e9e5badf155d29129b39fb7af474bc4c7ee142a53c", 
        "1bb4b3ddaf25e67ccc66770c2f47413b2417460a72ca61ee0d72d39e42dfa057"), (
        "2e2b8c08ed285ade22eadc53f7f165fafd68ff69cd9a1c38f7b1b0e95578a7c1", 
        "196dc800723f80d3af767a2b51d874b396f4222a9ac3d8308abb5a721d52ce4f"), (
        "2e83baf08662693cee151edff384f259b9793dfe5214bf2b04f3ad90d5a8cd17", 
        "04d404a2e406b1e9e069961a86daa98a22046a546eca793300555b172ae91989"), (
        "022f2f47364290282e85f8e2cd7fcf4a346a09f97ffffce59c474b7b33a99f95", 
        "06cd7d85da6f61db154e152be1ae02cbbf6054b9e445b7239223cefeec88e679"), (
        "1cb34f7d1e74bcdc1fa70a83533b6746b4218fdde331a60400c5fbbd4cd362d0", 
        "0f6df63f4f5f10e2bfb9d0ef88d34ae62850b24bc45e1c8a4e7f652701af0322"), (
        "23ae5d5cdcf23d5940c9edb018bd275f8b0627ce499570144994644803e3d3d2", 
        "13816093a98fe9c5b5180441e24ae8a14b464b4c5d3d67a8548fdcbf0652e75a"), (
        "1f4a130e81f7b8235ce0f8d1be55cd29bb0ce0c20b5f341472b28f47d657b44a", 
        "198de1c806777c6c97aae2178d6a707bb387ae316ebb81ea46ed55e31177b33d"), (
        "04c4b02c7e38a410ac7833e53519e4ace451f0db43b3e281afcd6ec98478a15a", 
        "14076e60b8cecbd44e7853be02c7af400be90810fc44611f8848a76862981871"), (
        "303bb4886b0448aca8844044ab141d7a6e8015511dae51e467c01a756bcaf482", 
        "025a3406e9dca3be4941c5e7af776a00200671a8e63b276ef1b05c2a6c18098a"), (
        "12490ac2f30f05d29eb822155eb54c87d9d6d407e597acd2c40c1ee87dd9d555", 
        "041d0f7353723fbf01b879873e3ea7eb116caf059288211ae141204efecefa27"), (
        "09c183f38f4939c34730070c8e40a9e1170a6c9a1ea2de1d07614f58f4775184", 
        "03a18d2f01cc6d806e273d725282be10917d0e44fdc25601e81f861c2d57bc25"), (
        "029011dd041c39900f44afec9bde49c047c7c8d98fe72ef8495ff4dadf46ecec", 
        "1f1ac817a635e6d82e1c204c0c018d7275cec7242406cc9db62df7caa7e122b9"), (
        "2558d8aa598541ecf010758b119e90af24610a00da4beba558b1a4f2d95f268e", 
        "0cdd4b468ef0cf2627c124b34812a36eb45377bb099f6cced23b93e9212ad9ae"), (
        "0f52ebbfa546e9f39ac6dc3ccf6ebb8bb9b9350ccc7d277a63aed3721518d799", 
        "30532d7da331dd982a46ebac45420da76ee2b267f873e45e49a27143557b2189"), (
        "294ed26529dfb8a0259d80e8379ff0b7c0770238bf2e90e7347fe29a14fde1a5", 
        "2f1cb401f0839e1081c3681cc56b87841eeb0fc4f800554d89c3cf54a2166a2d"), (
        "1c66254453e0f36b97cb1cb7cfeedb5d6149aaf147e00afde5b65b23da21d27f", 
        "24b35ebe700a2f00800f6a8b61334f385d13e118f6d9b0272957093ecc1ca49e"), (
        "213bc498a45437b71e846d22469ee4a0e424dde4b3a5e66bf968aa5db4c125b1", 
        "183c156f72de0625a97554b59242321ef95501531c65cf58ae5154d2399c0b36"), (
        "1ad8181f52261458350c9baa0938074bcfcab7f7840ba9efabab4948233645d6", 
        "10153f17e3dddb49bd688dd7b469ed9b6bb23634aa36b05b32d42c3130e0dad2"), (
        "2497d1f6f2efcf5a904b9b97f3ce347e4bbefc768d7ed132e17bfb6cea3aced1", 
        "21bb38990896c623ff412adeeed422ec079fa173f9564b5f531f799762b747be")]

    # StaticGroupMerkleRoot is the root of the Merkle tree constructed from the StaticGroupKeys above
    # only identity commitments are used for the Merkle tree construction
    # the root is created locally, using createMembershipList proc from waku_rln_relay_utils module, and the result is hardcoded in here
    StaticGroupMerkleRoot* = "2d7b393411745699c6c67cad60805b5c6a915a54a03216b2e112ff3e557a87a1"


when defined(rlnzerokit):
  const
    StaticGroupKeys* = @[("2c0198101a2828a0ac6c9e58fc131e1bd83326a4f748ef592588eeb8c3112dc1", 
        "1ca742a54641e2de14c5cb87ad707fd869693f682cedb901e47b8138918aecb3"), (
        "095177fd334629dbc29c5fc9e32addecfcb6a42f9673268810fa9f70d1a8191a", 
        "0e30810a60f53fcbd60b312d9d65ccefe4e9d0b0d2220d7350fdf881469e59eb"), (
        "131c6d4dbfb3feafc7fdd69aa62cd05d7b6be0cd7b7777ce9513ad742be71763", 
        "110ca13b7fa2ed72ccc4659a4fdaea3a2e28443617a29bbe977e92c83b531a15"), (
        "2f45043d0efabffadcc0db24d238a8bc4a30ce7394ee2a70b4f9c91ff675d3d5", 
        "23a76dd96b527d12f7d5cda1000cba8e4926b072a795d3a2bc13c479956038f5"), (
        "0ca272f013725eb1cfed07780a0ea6122e67d0c29717b26eb12c71dfd2367bf4", 
        "082663318217ad470c42f66cc66a888b296f92353d35151c31d8c611ce2cd1d4"), (
        "0d08566358b2af4b38c0ce7d92840d1bc71930a7591470ad8cabf457de60833a", 
        "28c6909a697e160d69ffda94e0f9acc9cca6d61c05b8bd78b864620313b7a808"), (
        "22b64925e839c488ef606d99d463f7af963b5634bfbc81a1e8c93597b65e1b66", 
        "2c1e7bf4af57bdadebb36ee840db5cfe88bb722d05ba24eb788b6dbcc2faffc1"), (
        "1c102745fffa271dbc1e6ba9d1e4d4cf03f0537e1c0937d7126453eec61afe79", 
        "2e57378468e7d3612379047dc0580a48eb75afacd827324b4c16cb18ed331bae"), (
        "2ef1ca7b105b932c78ae2b03b152a07dcf2ceb9459a718d417447c870559f388", 
        "05b7e60a719029aad98713ed5a0bcba3982e16a0befafe0d4763c8e2fef83c0e"), (
        "1aceda8f46cd198b7abbb79e45f6508af8999ca31332133d042dfc4a19201b77", 
        "2f3d259b8aabe16f645d4a6e66ba890d55e7f0cf594935ea852a0e2624868f40"), (
        "202de1595bc8e35e502a46124a067453d1e9c1b9f406acbac37c93be4bc1401e", 
        "1f5666cf374886ca7558658a7e9b5af5004f2bef9b65c5ff19394cd57082eac5"), (
        "162cf23e68b513465c1c392879ad7a3ce51fb98687777873c145cf32b0e2da23", 
        "1f3f115f1ecf136d740fa0927d2525beaa2fc965b7cbab4ce6f96d9fcc206e9f"), (
        "1c45d7e1421ae4df9a32bd2ea6f2bff70a4ed56762ef1358ee73bd8ee13e21f3", 
        "2417003e9c27c4fbc14c77e877074eceeaae6ace98f2b881c1c4eca2583c9c83"), (
        "0b0b3d09d843d911b283299bbcd8965e8e4534c66ef9752be1eb01dff69669f9", 
        "115b7c70b9a1f468295afdca9dba3b67ccc3123e5be74d5a8da73a029fa2e68c"), (
        "1b1b4f1fbc8804762e3e7ccb53c50921a5642431169cb49cb220eed33e40d5c9", 
        "2b7821ead551ba2a9a55450da9b21d6aaa4c382c50d9fcc9115b48a89f06a496"), (
        "067b456b971b40477a97b66672fbf259f5dc46669218272ed517d36716f0e43d", 
        "0f4cbafe9afbee252db6dbaf23a5975e24bf2d360b907f5c88bdd3e3be6bff6e"), (
        "18ee822f7abe8ac80aba210116b438d661a97dba2c0602456582a767e33e4589", 
        "02f812ffd5b9859fd202ad21c303b6352bda53af97dd944e9ae4161508191f55"), (
        "14c41f2ee56279e7bca332679c4ed5c865b83b4e7aa1be0415d4e5ef12a5c532", 
        "122f3326f332d5ff387bf8e3f4a2ac647636a2dbc69be9590664107f87ab8d3b"), (
        "29b1fe377ff7295120756108959ee7d6c8dc314c078086fd52743e81d3134ca7", 
        "1e47ec0b7957e911a9c3591a9df514413e437eb8549a61a2d13f9aa9f38559c5"), (
        "17d5b6d345b4ee67418a29ee18a6bed4976c1321ba0b299f2e25dca30a421c9b", 
        "233ef113d1b1c6659b1c964eba8a8b2336e9f71db3daa251f8a69968aeeff066"), (
        "14e40d11000392066c5624737ad96faed0e126cccec8eb4f8f7b5eed141c82d4", 
        "1d8bb23790d6105666913eb9bdb4ad06584e12bf428e46f034b546b9cbe05396"), (
        "0498600cbfb3fff26656fb8ecf7f5fc1212003d5391e6998330bae8b3453c426", 
        "2944f71c79f223b47d0ded89fea53ecd362d64314c39aa632046fd7c9bc366a3"), (
        "19137c8e6c8249e4897b260d387aea6afb82d0f36f9eef5018ea786dc6a8504a", 
        "2dbd8b02cbb6d5a8fc2a91ae5175019af9c9c003bcdcbb5d56590ba48ec353e3"), (
        "176f27c080beeb31b4d4726846185b41b0ed480b589645d18609759afe8847d0", 
        "1030d697176631bba1ac4179f6a1640a4d7b99b68484a4808f750fd58bcb4e23"), (
        "0383a55e14226eff828d4a3f6df6e3374d6a9e6538d9a36ba2161b5e88e4a3c5", 
        "25e4b8ccb1fe4f9cf90e60dbd9714902e3c76e95e39ebaadac0dc36b3b632129"), (
        "0c57de13726bee0b6fc5f04c45d4bc3fdc1f884eaf8ece07ac85b87d23875848", 
        "22f4ceb33f1a84d0d263aebc1d0850347bc126e9981dbcc4593aaa53e3861106"), (
        "06d159ec59bc4b0e9ec25e63fe3e29368059999e3c304b565789c776f89f0fca", 
        "144789e2e129d2282ecf5dd3b23286ab475a8eec7e066182f28ef71be14ce048"), (
        "242b10778fa6e753bb08f186b2e07c1c87c263057e09d9ce88333033f465799d", 
        "2feb99f0a004f1ee48046d72969eaa73ec5945fed1b8e41704d38fdee2b6afb6"), (
        "1359ff7f691d03c867ed1e10e7bffec09ffda9d9254565d5da8b3d472ef91edb", 
        "016f4071d37b38572bb3b4f07b86d47b1813bcb64caaf0fcf4c49388bbb8d534"), (
        "14263ca40720663eaa4e78cd9bc6336aaed42f83c30a20b4b62c5a5a9b053ed4", 
        "121d1ac2a73279e3b1ed99c044a5b240cd4345c6e944233b8850f85f91830656"), (
        "017e31163b233f56fa999c1433dbe6bf9f4e6c248d83f6a6f496866ea407cfa1", 
        "27e00d68571fb1b20f32ad2090125d39a781f3a80133d267a520c09e3e000439"), (
        "2668502cb436958df8b6036340c9cbfcd6f6cb4304a46d50621fa612869c8c17", 
        "0577e480c19501a7e1b03acc9e456c79af9b7c2405a005fa288340196290812c"), (
        "1cbe3144b594879735c43002b480bd83e83c4fe6cd430fc447c11ef862934bf8", 
        "0ff3b7fdb22a138cd90beec386f5cac06c3167dd2f25169199004472394f52ca"), (
        "221edbd101eb5300d45f30c5102b9cf61a4668de7b96c2428e726fbb2eccfba2", 
        "1ee78ea001663058670233fa4bd3f5eca125d2ee27166a3c270cc9ff828ef44e"), (
        "09f4c1a0a0acb6fd0bdbad6fa15fec36a053b04924f71c50158d386393dea791", 
        "0af261879fe9f9dc428d2d3ed1e2951e0b8ea45d2dd9452ae9657197ebc25bfa"), (
        "1c797777a6175c021f776a177617ff78c691075e61c5ab78a575696abf98256e", 
        "14acf51f86ed0f2cc202599a7b2c7d836036e80374a27ba4d1a015577ac0af22"), (
        "11b022742928eea62ef72d64b6156c7bc1a3df355e57d5c1edf29887b7d788e7", 
        "15aa67cf3c4bfcc267b5267c33b026cd8d7b19e2a6b3f8abef610da276419aba"), (
        "00323a544e19221877fa41066cc0f400f73b4d788e05192f9ba4c33559c113bd", 
        "1afab12d34efab0b919c5fcf9aa4250a13e48bf97c112f0451c8ab687cc93515"), (
        "0ff6ec8f949bc2c540fc661911215818212f37f37d1b041517bee13f01d01877", 
        "099ac3a4ae91b8aaaedb701d53c284931bdd4e1acf248cc435a2121b44d876e4"), (
        "03200d6a35588a4cae7342c9cb2160a596072f17e51b0071eec3eeef44df7a85", 
        "21785df67a48d487e7267175ceb1398d871fcf204d3507389c08fd818eae8e35"), (
        "22f6ffa9d3607ae5eb10610dc9198d1e836b5b67fdebe0e875f59ee41c49d28d", 
        "285af8a70a34a6d34e6d715d28b18869c74fa8c0a97cd5035c39b4ad9c9bef88"), (
        "131373e532a4c0e6730d023c8cc00a300ded84f0ff38ae8ef26b869ffd21a495", 
        "2617021b27ccb848203efb158e222e727929239acebc1bcfcfdab441ca2267d8"), (
        "2deaa385e5ac88d90c9ac88f4dd1390b570da7e3368820baddee878c1c920985", 
        "0775d7a6e69b2fc8d887ac4d8ba5f45a5d70ff1593d44ec7d68f125241a27019"), (
        "13a55e79d5843dd86599461865d3e41895ae7414778b5d6d7b3122f8a21b59f0", 
        "0023467c1f7de5335e1f25ae8a854dcd9afae22f8a8ebda13725827ad0b5781d"), (
        "0b6b34fa4f045993221dddc35b1a7d39b900bc74d6da3e75d85dbf3f6a9002a3", 
        "204d8b8dbc6fe2300c2a7998c6334aa772e8e31f9aa0521f074cebfca09076de"), (
        "07bf2bd503c4c08950b74961eae6b22c1dfa9866e1d9566561665ffd3c5f426b", 
        "0049bade3018d28f8c40a47c71f1415811dc6528f0bf6982abd09f4df6d45432"), (
        "2a2243a0405c0d40af17245e02e1c1f5aea007143fd17fe2fd93a2b49b3f0a57", 
        "112aab67ed0bacf225f87ff6591fc8d219a73b4dbfe36b21892a5795d481d4f3"), (
        "22a1fd33e4b83d1cbac4a92160ac8b41ef86774bd7885f69a8fa79fe6c33a4d2", 
        "2de16b061df3b291a664ef1e1eb285538d18b80aea7014ebf2b3e50d22888861"), (
        "284e390e5be08da632b0155b6ee23941b3275fd23682590c7efd1dcd78b69d5e", 
        "0a282a3b2e4462ea48c82933c2ed03d046058d24c39d02b7d012126adc79234f"), (
        "216ef8f66b9d3cab3ad9f95e041677ced8d59cfa987cc898d0db31ec17bc2d04", 
        "08cbcb81beaa2113b5710e5441032a7d7144121372ef9d2d903b8e76c44108d3"), (
        "1f5fe5d1a7eba65373f8c23b02b330e24677fd8fecc8142f4af2df2de6a9cdc5", 
        "18818a95dc1a2dceeaf5484b2324b6f2977ba0a8120d4d19b9a1bac7482a25d6"), (
        "02f4a10357e1b8fcd3c8d6fa3cbe498a4451cc0d3c29075addc853c7e0b851b7", 
        "23f50656c54f84cbce760335ca09d50f27ab160f7fcea39ceb49d9d5aef67a29"), (
        "1ae88ec49df2fa49d2f1d3170a15b2c5a80fc950ab0b50d28a6caa20aca6722c", 
        "08f18be90156d957e2328367d7fd661d6c5bcb167193961c7f9b7d7bb82855c0"), (
        "152b2f54041f1a615225bc96723dae89fd0d17352b0d37b37f419e49332f3a84", 
        "087ea7a796503b43cd723344004d4a6c869f9c779ef5c96b4f385c1b6a16f585"), (
        "0ce422373db69ea5f19ad22480b6b5052c8e2d66e3bde5cf9a3a43998e699f32", 
        "3034885d053bdcb7074ff7bd67f5b6d3dfc27be07986ae27ae65f99f95670b91"), (
        "0ea472ec17bba7b8d9e7c522d9d5b0b8404ae1da0f6998c7e1acbc5433f3002e", 
        "1eb8eb2cf399ceed4b9c4894d1cba611d78f2aea9ec3bb04e4f4502c6e72504b"), (
        "20769b227bb7d3cd8f08a7c3a58e557d87a645601dda0a89b322cdc4a29dc073", 
        "13b601dea1b88605d1479331596128fcff755118259802a2ef28e7aa3a7900f5"), (
        "207c117d42d91e6b6d4c0451aa96f38d7d86a0dda678440f4a1b79ffe9efc825", 
        "064790db9a228621e867ba894c0e7f3a0b178c0eae72892dc743ee62d5c557eb"), (
        "2ed78374a4b336bcb8fd8603610059ff51dac1cc7c6dd3549c072101e0443f86", 
        "2c1d57b17d1f0fd9cf00fa9409ecb47624c8685bd632f447a3c15ab0b1d90fc3"), (
        "073fee805a6121d1cac9f68ab6b5759313a82100e9b59e70a84589f1e311736a", 
        "1c61cc79a8a9c061385ea2f7899171f5d870b0f5de27b6acd5387d7caa8f3d1a"), (
        "2fe95c45a1c3ed3f81a9713762c8f15edd783207a2343f866466474be47cd297", 
        "137d8a12344f774e17c852313526c982927a08050b8add27ad8fe8feea29c49f"), (
        "10c3634849afe5a64bb5325770dc2ab1045bead339fa995397cda85e5bb48aa8", 
        "1cc853ceab6fe0a2e0396f5e58ff96ffd7280907c44c77d2327e34018bcf2924"), (
        "26853b411ff5829880b6305740a15c245b4246e84ffc6d61722966f466a4eb51", 
        "1d3a27beef286cb47d716de1b6b93b1c090e759a9538395a38bb804cdb2d11f9"), (
        "2b4ea98233ee2eac4df809f2620bbc6b183b956561e1eb25c8b4a84a28ffe945", 
        "1c82f94e2e952156c1d759d3f93fc97bf8f8a444183e578cb62001e1bbaf32d9"), (
        "1c047970753dda8c20b8cc4a40721847d26dff8634b72d02e8d28e3b407c80d1", 
        "195e38c09efa924609232323395867ccd8f913dd7a4fe4322a043f6eeb51ed7a"), (
        "01c2cd45a421cb629b5d4752380f296f98ba923a6ee9b28c3f427f236138c9b9", 
        "160875e6eceeb3e3abfbaea572d16e7a4c1df16a906f18805d1db031bbe25ae2"), (
        "1ac75381eb5d3bb34dbf46b3e8deaf88822bf59880cd206f2b88a7cb0cd78a55", 
        "2198af5533f0829ee6a02cd9f7f9d50de57e15f08d86fc8d18eb9d6f7b3751c6"), (
        "254c281c6a72e0fadfe88280dcf1353b1880db14634863cab2fc18fc38ffe4b6", 
        "1ba0e9722e2f2911610966004407991a8c7f41c5c4bb78f15b9809aa45b6ed2e"), (
        "2786cdfc7446c95c3f3a83d851d0c50cd3ee96bb91bec1bb9a3308907dab64c2", 
        "2bfe013073d942cfb1793c0aa8d14a5e09f7d5ac7c8f6dd5119ef730c232d78f"), (
        "1a809572677c00af2d52023bc2aaa3d43d8b6f16f7576a357f82471081b2298b", 
        "13ff785c5a8ec7ab13291759c37499d32ab95edededf2e7c08eb3e5d0dd0b4e4"), (
        "2ef26ceeca603bacaae271072909a22cea69fce5f299865c66f5ae63b45dbe30", 
        "0ed774428015317b7d299500c5e4d01e49039bcfebe5db3ab1034c664d975e3c"), (
        "2d5d5b1d825b27f2345976f3d43e47017c1efc41e8e62f93b0e12c1037b316db", 
        "2343a52d8a37d986fdd52c31d5742a84f51088c002f4dd4e4b039960a504cbdb"), (
        "172e2144b6ded94be4b9642c7c6f9afed81aecb5485aeef5b3d054f53aa2756f", 
        "2406c9401b7cbd9494f429616ffc85a489bfbdb6f914bd84640b28528dbfce68"), (
        "285af6cd43a017bec5394152e13a2ca4df2131b32c28cc9df9b45c24aa0bd0e3", 
        "0f79493ffde795d083b097734356107f41f33137b6bc7118f2768c924cf31057"), (
        "00117742394adf01ad59a127f0a0bec58f8d4e593c589266ed15041422f382f3", 
        "0fb47c14a31f6be53718284a8f35f3a7be7445acb7685893b007a22da26dfb4b"), (
        "041d9eed43c71e705a9a4ab0f3d20d27e27cc86f494db2579c20166fde4fe733", 
        "1f37f81316470689a67a8f6fc22a8000870affa7f69a53c0538240bae147e8e1"), (
        "2c43ad22585ba0e1c836782ce619ae0579ac376efe2c433c3d29257fc65d4b3e", 
        "0303d6adea59b2538c8c625761396228fbd552e36d93af02d177c1219ba778c9"), (
        "2931a506675b34076d279296b1fb36d8d2161568210754bc0ada09206b956814", 
        "2a650ed20b09a37b6c99f4ed99e352069979306db538c9e85d8e4f24990df7ee"), (
        "0199bb1cb7798516759aecedc974db39f8ecc9befbf97265b224c17b66b241c6", 
        "18ba142aaa522112b47c2ebab08a483e01e75b7931024b1accca5e7ba557b983"), (
        "2fc6e58b52fb6bdcde370f5849c990c542dc112c42100323dd199a3a90c3c55b", 
        "1be44b8c0fbc328fe46ed9ad8d62d85c6058df7a5a1eadd3d88d018dfdca2d5e"), (
        "0e5928b37cd899cd186c0b5ed2d2b9034b82fa542420903c25aab9d835e16697", 
        "0db6cc4f93d7c62a819ff05218e7f97deed2899ff87e9316048afa3d5f88f8d3"), (
        "1c4ad5b10dc591d28b111f17bdf06c4d52fca3f598a16918f0c22adb1046b6fe", 
        "0fdbbf0beb5a7e9fe36eb5950a8a42886c985c35a753193dfb88b2289bcd273e"), (
        "254cc2e093b44b9817d6e63b200e901719ee2c71cf08122845ae17c83df11b57", 
        "0ce7d93826ead805dccb2db908df05af4b8eb253ffba9f7e12f5b65c790e2f13"), (
        "082d33c58b7ef35450b6e0f04228af71cb62c24b65facdca8a786448939a64fb", 
        "1eca9298aee68fec2c3485fe7b46b154b2d28dac651d4692143da495e1a6a567"), (
        "135441db7e663906d2a3fe179541475c568dfe5100a7bb0d711bb8fca34d6dbd", 
        "2832f9e2f973d3c679905fc1c173b71384c54d0c86be08ca053052a1e516fc07"), (
        "1d979375e1e725d394b017452863a2375a349072add1a1f4e8a62783e29997e4", 
        "16d4c4d52996d207d2f5111e6be2a333f575cd63a5d71df24e413ec239441a64"), (
        "241e5996499e43372a4e86c30a1f141d6157eb175b939da7b08a19522a52bac0", 
        "129341569c322516d77c426ebcfef6d7f40e5338d15c31a5aa3bcd056008fe78"), (
        "2269de57ca36264ec72dde1c8ebacee471960cc2fad7c0ee3a9118ba40e41e87", 
        "2aae3a1043157c1bf2c79e6111cdc46c7e1a2bc960596eb023b7b8c6227c2e9d"), (
        "120cb3d07e7560d2146397bdf872004fa29eefc5a5113595be164ecd72125aab", 
        "1e21ba2aec2eaaae2595695d5b638a27433bd883b8e17f6f8fe1fd1b3421fceb"), (
        "1bc45135b0cffa828ee41ce1c65b64d9f3f65390684401e903c9964099919e2c", 
        "0083742467cf09853010726529661bac06864c91da35300f630e8cc78c61cbf9"), (
        "233135b00df8453eaebcd34d338014d01efbabebb3ddfe6219dd7f5db7a341ba", 
        "07fd4cd97e761f7391eb9718baddef0acc9a6dba3dedaef40612754a2dcdee39"), (
        "02fe17ec7b1ccc29368b8f654442db237d8cd8221edaff653220ca0beffef1cc", 
        "0cf8adbfd9140830b15670269f6c9e7a39b6172e2b0e059998403ee609323c09"), (
        "11221c9f08070d40f1368e0818d2f31c93312b98954bdd1f0f820d68be592f7c", 
        "16de82ddd15ed3809e392ae92a0d67dbde6abeede876c7cdf8e6fa106721eb67"), (
        "12c0d0c606aa1cc11896de752de3b071793b0d40bc1c76224bf709a73f3e0694", 
        "184d0476ead3701a7ffb62d0ae2b43e3ebc41cb27d4d558c09e9092f50fceec2"), (
        "260904e50145e0dab40c86488a48f1a857915058f3b263b2d7d4325e71788abd", 
        "14c9bf7f4c25a6a69a83652a57853462149761ec82954678345c8811abc2daf9"), (
        "2a1ceaa3461f3e3e6539c1d5f58823753c2bab300fc7b995be94f510f4d842c7", 
        "05a4f98932e76eb1a8b4714c6b3bf079aa022750d4d8a6c9761b34b0578ba239"), (
        "0d344bf806ab8566bea729eea160fee2e0f685416b577ca8bee0b4346be74cb7", 
        "0b55b69e6183e03e3ff83e9397e6c4fd7a530a17d77687e98da9346f436fbefa"), (
        "2fbc760addd5f584378b071acb9f8ecb4aa9d40bd640d352db3f56a0d0b3f389", 
        "2cd8a28452aead0fe6860fc152a8d15568d2a7fd41bb3d907a93ee8bdce2e554"), (
        "0d0b7216902409e7a4c2588c59b002bdd3f739954deb6869fea6424c26212b6a", 
        "1d2a5e216d4e4cfced68bf71e68721fdd9297bd0c3c790432156f029d63820a0"), (
        "0ab175fa60fe331351385be1eca5174511d284f674b6ba4cf58acb47c018f5a7", 
        "03aeb24c83f1a5d343d9cfb6c124f6cea32113a4d02c063bbeaa937ff1a492e0")]

    # StaticGroupMerkleRoot is the root of the Merkle tree constructed from the StaticGroupKeys above
    # only identity commitments are used for the Merkle tree construction
    # the root is created locally, using createMembershipList proc from waku_rln_relay_utils module, and the result is hardcoded in here
    StaticGroupMerkleRoot* = "2b5c4a3a12d98026e2f55a5cbfc74e8a5a05a8f5403409bf218bbc92ace25b80"

const EpochUnitSeconds* = float64(10) # the rln-relay epoch length in seconds
const MaxClockGapSeconds* = 20.0 # the maximum clock difference between peers in seconds
                                    
# maximum allowed gap between the epochs of messages' RateLimitProofs
const MaxEpochGap* = int64(MaxClockGapSeconds/EpochUnitSeconds)