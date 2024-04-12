# Changelog

## [1.15.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.13.0...v1.15.0) (2024-04-10)


### Features

* chat list ui refinement ([#507](https://github.com/lemonadesocial/lemonade-flutter/issues/507)) ([2f8b0b5](https://github.com/lemonadesocial/lemonade-flutter/commit/2f8b0b5e0802a5c8f563d28542552ea48e7172e1))
* create lounge post ([#505](https://github.com/lemonadesocial/lemonade-flutter/issues/505)) ([f560f5e](https://github.com/lemonadesocial/lemonade-flutter/commit/f560f5e47f5d41fbc6bb7f924c11b1f4bd9e1773))
* enhance create event ([#514](https://github.com/lemonadesocial/lemonade-flutter/issues/514)) ([1ea4cec](https://github.com/lemonadesocial/lemonade-flutter/commit/1ea4cecb21d191fce344ab871f278d3fa664a07a))
* enhance edit event & description markdown edit ([#525](https://github.com/lemonadesocial/lemonade-flutter/issues/525)) ([b23afca](https://github.com/lemonadesocial/lemonade-flutter/commit/b23afca939d06ccd4a4d51cb34282ba640a65f0d))
* guest triggers mail event tickets to guest's email ([#509](https://github.com/lemonadesocial/lemonade-flutter/issues/509)) ([92b86fc](https://github.com/lemonadesocial/lemonade-flutter/commit/92b86fcb6553a6e0f4ba59bd351c244598413ad3))
* mail ticket payment receipt ([#519](https://github.com/lemonadesocial/lemonade-flutter/issues/519)) ([43c02c2](https://github.com/lemonadesocial/lemonade-flutter/commit/43c02c201e71c8a8b5376861c2301891faff0b8c))
* update api declaration for ios ([#517](https://github.com/lemonadesocial/lemonade-flutter/issues/517)) ([7e6b0ed](https://github.com/lemonadesocial/lemonade-flutter/commit/7e6b0edaff14ab1bd1386d92eb83085688cb2f0c))


### Bug Fixes

* add follow function to event host list ([#521](https://github.com/lemonadesocial/lemonade-flutter/issues/521)) ([b92ba5c](https://github.com/lemonadesocial/lemonade-flutter/commit/b92ba5c3556a5d050e04b955677573810ef98e5b))
* enhance sentry stack trace when calling gql ([#512](https://github.com/lemonadesocial/lemonade-flutter/issues/512)) ([d1967a7](https://github.com/lemonadesocial/lemonade-flutter/commit/d1967a7248f2de0ac2eda4ee112a2f26a2759871))
* fix format invalid double when set guest limit for ticket type ([#522](https://github.com/lemonadesocial/lemonade-flutter/issues/522)) ([4e7fb0d](https://github.com/lemonadesocial/lemonade-flutter/commit/4e7fb0d0c40579ab6be8260b1293b7c5f1fd4db2))
* increase appcast version ([#524](https://github.com/lemonadesocial/lemonade-flutter/issues/524)) ([88d62dd](https://github.com/lemonadesocial/lemonade-flutter/commit/88d62dd354f58c64390744940c6ed73fd426767c))
* lounge bugs ([#520](https://github.com/lemonadesocial/lemonade-flutter/issues/520)) ([5027f0c](https://github.com/lemonadesocial/lemonade-flutter/commit/5027f0c00e81bfeba86ed1a5a7157975f7082caa))
* move all logic check at event buy button to bloc ([#510](https://github.com/lemonadesocial/lemonade-flutter/issues/510)) ([eac5b74](https://github.com/lemonadesocial/lemonade-flutter/commit/eac5b740e261be6dc4fc45a90d56228f0850fc0e))
* optimize get price decimals in event list ([#513](https://github.com/lemonadesocial/lemonade-flutter/issues/513)) ([073bf16](https://github.com/lemonadesocial/lemonade-flutter/commit/073bf16e6d6ce68616dcee2953efdbbf67923be7))
* remove getting event join request if user not logged in in event detail ([#511](https://github.com/lemonadesocial/lemonade-flutter/issues/511)) ([251e584](https://github.com/lemonadesocial/lemonade-flutter/commit/251e584f3b13fb408f357c53e92ab01392c8ecba))
* toast icon crazy big ([#523](https://github.com/lemonadesocial/lemonade-flutter/issues/523)) ([2d3b9a0](https://github.com/lemonadesocial/lemonade-flutter/commit/2d3b9a0bf8796009069cfd61d782590c53265e80))

## [1.13.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.12.1...v1.13.0) (2024-04-01)


### Features

* event lounge listing & event guest directory ([#499](https://github.com/lemonadesocial/lemonade-flutter/issues/499)) ([86b70cc](https://github.com/lemonadesocial/lemonade-flutter/commit/86b70ccce719f18b8334bf9aab44449db3ce9358))


### Bug Fixes

* prevent uninvited guests to select tickets on private event ([#502](https://github.com/lemonadesocial/lemonade-flutter/issues/502)) ([c538cfa](https://github.com/lemonadesocial/lemonade-flutter/commit/c538cfa96610bbdbcf30de76031381c94c08e5bf))
* remove unnecessary navigate to event select category if categories is empty or only 1 item ([#501](https://github.com/lemonadesocial/lemonade-flutter/issues/501)) ([3d3c462](https://github.com/lemonadesocial/lemonade-flutter/commit/3d3c4626c889200bb14fdbfac9c5520e89cb4bcc))
* use fadein transition animation for initial pages in event buy tickets route ([#506](https://github.com/lemonadesocial/lemonade-flutter/issues/506)) ([642bffc](https://github.com/lemonadesocial/lemonade-flutter/commit/642bffce4c654085b172ffb63a7f8d78a5d1f0f7))

## [1.12.1](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.12.0...v1.12.1) (2024-03-28)


### Bug Fixes

* handle ticket_types_expanded and resize post image in newsfeed ([#497](https://github.com/lemonadesocial/lemonade-flutter/issues/497)) ([bb90d5e](https://github.com/lemonadesocial/lemonade-flutter/commit/bb90d5e146f0bc407f1e5584a0e96d8c1dfc597b))

## [1.12.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.11.0...v1.12.0) (2024-03-28)


### Features

* bottom toolbar refinement ([#475](https://github.com/lemonadesocial/lemonade-flutter/issues/475)) ([76ab9a1](https://github.com/lemonadesocial/lemonade-flutter/commit/76ab9a19bee5288a0c85071c35611dbd904b10bd))
* bring back event bottom drawer ([#489](https://github.com/lemonadesocial/lemonade-flutter/issues/489)) ([f237fa5](https://github.com/lemonadesocial/lemonade-flutter/commit/f237fa5f0de78be9142233c02e1060390d573b48))
* edit social profile ([#491](https://github.com/lemonadesocial/lemonade-flutter/issues/491)) ([41c293f](https://github.com/lemonadesocial/lemonade-flutter/commit/41c293f1a73aa1b8480c5fb763661452231ae19c))
* event ticket category ([#473](https://github.com/lemonadesocial/lemonade-flutter/issues/473)) ([2de3342](https://github.com/lemonadesocial/lemonade-flutter/commit/2de33428e06926775587c605bde5370350bf1b01))
* integrate sentry ([#484](https://github.com/lemonadesocial/lemonade-flutter/issues/484)) ([e99fab3](https://github.com/lemonadesocial/lemonade-flutter/commit/e99fab38e7fc5dc510892fda12c14807a747fbcc))
* lock - whitelist ticket type ([#470](https://github.com/lemonadesocial/lemonade-flutter/issues/470)) ([86aadf3](https://github.com/lemonadesocial/lemonade-flutter/commit/86aadf3f0db877cf8dcaa392372f4a1b7e1c3c4c))
* locked/categorized ticket types for guest view ([#479](https://github.com/lemonadesocial/lemonade-flutter/issues/479)) ([2de7230](https://github.com/lemonadesocial/lemonade-flutter/commit/2de72300238b2889a52bf2bf092f0d36f237ec06))
* remake snackbar ([#478](https://github.com/lemonadesocial/lemonade-flutter/issues/478)) ([ee33ad0](https://github.com/lemonadesocial/lemonade-flutter/commit/ee33ad085bc95082f27c1eb9fa2ea3dad465220d))


### Bug Fixes

* enhance select currency dropdown when create ticket price ([#490](https://github.com/lemonadesocial/lemonade-flutter/issues/490)) ([6f34173](https://github.com/lemonadesocial/lemonade-flutter/commit/6f341739ba1fda29acf4e51a626f31d4fea65a1e))
* fix typo querying payment ([#492](https://github.com/lemonadesocial/lemonade-flutter/issues/492)) ([1857bce](https://github.com/lemonadesocial/lemonade-flutter/commit/1857bcef33d35efd0d7907b73966e4b36dd43d42))
* missing refresh event when approve decline join request ([#488](https://github.com/lemonadesocial/lemonade-flutter/issues/488)) ([6bd96f2](https://github.com/lemonadesocial/lemonade-flutter/commit/6bd96f219651f12f7395b50378e1ab8fff2fc9ef))
* post item title overflow ([#486](https://github.com/lemonadesocial/lemonade-flutter/issues/486)) ([4fafd4e](https://github.com/lemonadesocial/lemonade-flutter/commit/4fafd4e2ee8b385c892ba371a6c11f7e509c95b1))
* refactor event detail layout ([#485](https://github.com/lemonadesocial/lemonade-flutter/issues/485)) ([e8095ae](https://github.com/lemonadesocial/lemonade-flutter/commit/e8095ae074d1be9b9784247fcb139237a40a1867))

## [1.11.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.10.0...v1.11.0) (2024-03-22)


### Features

* event application form setting for host ([#463](https://github.com/lemonadesocial/lemonade-flutter/issues/463)) ([6edc96c](https://github.com/lemonadesocial/lemonade-flutter/commit/6edc96cac7bf65a3bc20ab056a1865439767b851))
* event approval status for guest view ([#461](https://github.com/lemonadesocial/lemonade-flutter/issues/461)) ([01f0b4a](https://github.com/lemonadesocial/lemonade-flutter/commit/01f0b4a758b9284d3d2cc61269885d961843bab7))
* get event applications answers for host to review guest application ([#462](https://github.com/lemonadesocial/lemonade-flutter/issues/462)) ([5f80d54](https://github.com/lemonadesocial/lemonade-flutter/commit/5f80d54ab95c0314dd7185c1fd16bfb60e3e927e))
* guest application form ([#460](https://github.com/lemonadesocial/lemonade-flutter/issues/460)) ([94bfd53](https://github.com/lemonadesocial/lemonade-flutter/commit/94bfd53cf3c4a42f881075a0aa10e782bf4bd5e9))
* handle more socials url for user profile ([#466](https://github.com/lemonadesocial/lemonade-flutter/issues/466)) ([b475f98](https://github.com/lemonadesocial/lemonade-flutter/commit/b475f987e6f0090aa159fe2a66a2850573bd22b5))
* host tracking escrow payment ([#464](https://github.com/lemonadesocial/lemonade-flutter/issues/464)) ([8c86f89](https://github.com/lemonadesocial/lemonade-flutter/commit/8c86f89f93eb59d67c94eabdd44248f852437079))
* rsvp statues for guest event detail ([#468](https://github.com/lemonadesocial/lemonade-flutter/issues/468)) ([6b6fdd5](https://github.com/lemonadesocial/lemonade-flutter/commit/6b6fdd5b3ae3cdfa3866a2ae9839712b1e244cb3))


### Bug Fixes

* handle fallback for payment flow when noti not coming up for too long ([#458](https://github.com/lemonadesocial/lemonade-flutter/issues/458)) ([cd02fc5](https://github.com/lemonadesocial/lemonade-flutter/commit/cd02fc58076d34b4cf37dc6b73f67b60ce50da72))

## [1.10.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.9.0...v1.10.0) (2024-03-07)


### Features

* event features bar animation ([#451](https://github.com/lemonadesocial/lemonade-flutter/issues/451)) ([289a288](https://github.com/lemonadesocial/lemonade-flutter/commit/289a288dc0e690c5917915febb6b2ea20dce267d))


### Bug Fixes

* hide discard warning if no tickets selected ([#447](https://github.com/lemonadesocial/lemonade-flutter/issues/447)) ([67d7201](https://github.com/lemonadesocial/lemonade-flutter/commit/67d7201fb60514f8adbec4fa0a9a4a26c2bc26e9))
* pop setting page after logout ([#449](https://github.com/lemonadesocial/lemonade-flutter/issues/449)) ([0cb13e3](https://github.com/lemonadesocial/lemonade-flutter/commit/0cb13e394f3273892c20a449fabcb52fc60a2f54))
* update navigation logic for guests tab in host event view ([#446](https://github.com/lemonadesocial/lemonade-flutter/issues/446)) ([56c10ac](https://github.com/lemonadesocial/lemonade-flutter/commit/56c10ac01989df113f379a2be2d9274781408902))
* update snackbar to top using another_flushbar library ([#453](https://github.com/lemonadesocial/lemonade-flutter/issues/453)) ([e9dfd9b](https://github.com/lemonadesocial/lemonade-flutter/commit/e9dfd9b718e07a3b25339ca8a7fcbf670c309c19))
* update user profile ui ([#448](https://github.com/lemonadesocial/lemonade-flutter/issues/448)) ([c6c7b86](https://github.com/lemonadesocial/lemonade-flutter/commit/c6c7b8689aba0411553f2106222ee4fc913240a1))

## [1.9.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.8.0...v1.9.0) (2024-03-04)


### Features

* add my events shortcut from app drawer ([#439](https://github.com/lemonadesocial/lemonade-flutter/issues/439)) ([dae3726](https://github.com/lemonadesocial/lemonade-flutter/commit/dae37262598adc739bd75968c04458279ca04c29))
* basic invite event flow ([#443](https://github.com/lemonadesocial/lemonade-flutter/issues/443)) ([6f18a01](https://github.com/lemonadesocial/lemonade-flutter/commit/6f18a01e8f788ec33ae30531f69a6ad6a0a68391))
* my events ([#444](https://github.com/lemonadesocial/lemonade-flutter/issues/444)) ([a5beab6](https://github.com/lemonadesocial/lemonade-flutter/commit/a5beab654e814b175f33a9787fc0d8d865e309ef))
* support universal links ([#418](https://github.com/lemonadesocial/lemonade-flutter/issues/418)) ([84f6b15](https://github.com/lemonadesocial/lemonade-flutter/commit/84f6b15a8d0a85ff26bad7a7c65da6a6e28df2f4))
* update payment flow for 100% discount code ([#437](https://github.com/lemonadesocial/lemonade-flutter/issues/437)) ([4c62a6e](https://github.com/lemonadesocial/lemonade-flutter/commit/4c62a6e43671ff32a05d4581069c5665592b72f0))


### Bug Fixes

* event program for guest refinement ([#440](https://github.com/lemonadesocial/lemonade-flutter/issues/440)) ([ad90740](https://github.com/lemonadesocial/lemonade-flutter/commit/ad907402647a455426afe0febcbec5b7da8a1efe))
* request notification permission android ([#441](https://github.com/lemonadesocial/lemonade-flutter/issues/441)) ([6332477](https://github.com/lemonadesocial/lemonade-flutter/commit/6332477f2c68a688465e62d5b888ea231d55b0c7))

## [1.8.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.7.0...v1.8.0) (2024-02-29)


### Features

* display collectibles for host event ([#431](https://github.com/lemonadesocial/lemonade-flutter/issues/431)) ([d3bcc97](https://github.com/lemonadesocial/lemonade-flutter/commit/d3bcc972bbd259446f29775ddd93d9f7d6ca8b3c))


### Bug Fixes

* event detail not refresh correctly when finish update event detail ([#432](https://github.com/lemonadesocial/lemonade-flutter/issues/432)) ([9dbe88a](https://github.com/lemonadesocial/lemonade-flutter/commit/9dbe88a8c02f2f088c8f0ec2fd495380ac9e3b07))

## [1.7.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.6.0...v1.7.0) (2024-02-28)


### Features

* add invited and checkins list to guest approval page ([#428](https://github.com/lemonadesocial/lemonade-flutter/issues/428)) ([8188d5a](https://github.com/lemonadesocial/lemonade-flutter/commit/8188d5a9159b9d56e0c0061934073d1bcacf83dd))
* add loading animation when issuing tickets ([#420](https://github.com/lemonadesocial/lemonade-flutter/issues/420)) ([2a913c6](https://github.com/lemonadesocial/lemonade-flutter/commit/2a913c66334227c39b48076361ba191a9af010f0))
* event program ([#412](https://github.com/lemonadesocial/lemonade-flutter/issues/412)) ([e0695f0](https://github.com/lemonadesocial/lemonade-flutter/commit/e0695f055e6d0e089d13c0ff502183c66535bcb9))


### Bug Fixes

* add view map option for event location, fix navigation when press event statistics ([#424](https://github.com/lemonadesocial/lemonade-flutter/issues/424)) ([8626183](https://github.com/lemonadesocial/lemonade-flutter/commit/8626183447b236118ae039b59488761ea8c429de))
* fix issue event statistics is reset when udpate event ([#423](https://github.com/lemonadesocial/lemonade-flutter/issues/423)) ([ba0d8f5](https://github.com/lemonadesocial/lemonade-flutter/commit/ba0d8f536f3af2d48b30e954dabab67ce4c1652c))
* remove delete text in notification slide ([#421](https://github.com/lemonadesocial/lemonade-flutter/issues/421)) ([b142205](https://github.com/lemonadesocial/lemonade-flutter/commit/b142205c517d57c1800058088896b7a092430dad))
* show sender avatar in matrix chat ([#422](https://github.com/lemonadesocial/lemonade-flutter/issues/422)) ([4710866](https://github.com/lemonadesocial/lemonade-flutter/commit/4710866184b9d19db452a997ab6a4b8ccee3aa3c))
* show wrong event price on newsfeed ([#427](https://github.com/lemonadesocial/lemonade-flutter/issues/427)) ([31edbc7](https://github.com/lemonadesocial/lemonade-flutter/commit/31edbc79ebdcbc6a5c9a643cd6746ecaabda58e5))
* weird UI issues + lock orientations ([#429](https://github.com/lemonadesocial/lemonade-flutter/issues/429)) ([d756dc5](https://github.com/lemonadesocial/lemonade-flutter/commit/d756dc5f7c59cf1408e2771f66431865bd1eb264))

## [1.6.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.5.0...v1.6.0) (2024-02-26)


### Features

* issues tickets flow ui ([#406](https://github.com/lemonadesocial/lemonade-flutter/issues/406)) ([beee416](https://github.com/lemonadesocial/lemonade-flutter/commit/beee4160dce8734d6a0ae7e9e8897ceffbc08817))
* issues tickets from host to user ([#414](https://github.com/lemonadesocial/lemonade-flutter/issues/414)) ([76951bd](https://github.com/lemonadesocial/lemonade-flutter/commit/76951bd0779798710b3d656355993fffd729b1d5))


### Bug Fixes

* navigate to vault screen in profile and enhance navigate to chat in event detail ([#416](https://github.com/lemonadesocial/lemonade-flutter/issues/416)) ([422ab7f](https://github.com/lemonadesocial/lemonade-flutter/commit/422ab7f2002be569056867df883bd087fe2e91f3))
* show view guests button for auto approve event ([#415](https://github.com/lemonadesocial/lemonade-flutter/issues/415)) ([88451ad](https://github.com/lemonadesocial/lemonade-flutter/commit/88451ade70acb8cb16ffd30fbdbf0048cfb67824))

## [1.5.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.4.1...v1.5.0) (2024-02-23)


### Features

* enhance UI of guest event detail ([#399](https://github.com/lemonadesocial/lemonade-flutter/issues/399)) ([0a7b5f6](https://github.com/lemonadesocial/lemonade-flutter/commit/0a7b5f6559e1c35e669d6b54bee436be8ab67a2f))
* event host approval UI update ([#398](https://github.com/lemonadesocial/lemonade-flutter/issues/398)) ([75e2cac](https://github.com/lemonadesocial/lemonade-flutter/commit/75e2cacb12d7cd4d5d8f1241aa2b157a2319bc61))
* host event detail UI ([#405](https://github.com/lemonadesocial/lemonade-flutter/issues/405)) ([e7113c7](https://github.com/lemonadesocial/lemonade-flutter/commit/e7113c78a9fbc0ce39d2a2ff138e60bc2b793a33))
* migrate to official wallet connect library ([#393](https://github.com/lemonadesocial/lemonade-flutter/issues/393)) ([505baea](https://github.com/lemonadesocial/lemonade-flutter/commit/505baea1d04b1916fd6dcf5710407d421fe91396))
* new file uploads ([#392](https://github.com/lemonadesocial/lemonade-flutter/issues/392)) ([7929c64](https://github.com/lemonadesocial/lemonade-flutter/commit/7929c6469bf1d8cb6176aa5b124c4ba8119330c8))
* upgrade fvm flutter version to 3.16.9 ([#387](https://github.com/lemonadesocial/lemonade-flutter/issues/387)) ([9c3c80a](https://github.com/lemonadesocial/lemonade-flutter/commit/9c3c80a16bc542212e5a21297517ccb34eab5b4b))


### Bug Fixes

* check cohost permission in event detail ([#410](https://github.com/lemonadesocial/lemonade-flutter/issues/410)) ([b0d9fbb](https://github.com/lemonadesocial/lemonade-flutter/commit/b0d9fbb5e5aee6740523d68c768ec026de41cce5))
* check network null or empty ([#403](https://github.com/lemonadesocial/lemonade-flutter/issues/403)) ([40a91f6](https://github.com/lemonadesocial/lemonade-flutter/commit/40a91f6f37095ac92fb661c5768e3f278a8c3b36))
* event host item avatar crash ([#401](https://github.com/lemonadesocial/lemonade-flutter/issues/401)) ([2a2793f](https://github.com/lemonadesocial/lemonade-flutter/commit/2a2793f11e831052bca97939687320eb75e88a16))
* lagging event detail issues ([#396](https://github.com/lemonadesocial/lemonade-flutter/issues/396)) ([34453b3](https://github.com/lemonadesocial/lemonade-flutter/commit/34453b38c4f0d136f65fcc082539172e5092d549))
* layout claim poap success popup ([#404](https://github.com/lemonadesocial/lemonade-flutter/issues/404)) ([f53b292](https://github.com/lemonadesocial/lemonade-flutter/commit/f53b292f324e16aae6f82def4caba1d630526626))
* minor issues ([#397](https://github.com/lemonadesocial/lemonade-flutter/issues/397)) ([ed3600a](https://github.com/lemonadesocial/lemonade-flutter/commit/ed3600a1ca08e4a9178210881a9808cd434442cf))
* new photo expanded breaking in user dto ([#395](https://github.com/lemonadesocial/lemonade-flutter/issues/395)) ([1b94a06](https://github.com/lemonadesocial/lemonade-flutter/commit/1b94a063eb2918c711605468c654243f1289fe6b))
* show join request total payment amount ([#402](https://github.com/lemonadesocial/lemonade-flutter/issues/402)) ([bb2dc08](https://github.com/lemonadesocial/lemonade-flutter/commit/bb2dc08e3e4b2fc74b4a4471ae3c4cde2dee934c))

## [1.4.1](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.4.0...v1.4.1) (2024-02-01)


### Bug Fixes

* update my tickets page api and display price logic ([#388](https://github.com/lemonadesocial/lemonade-flutter/issues/388)) ([d154c24](https://github.com/lemonadesocial/lemonade-flutter/commit/d154c24969dec53ac8ca6454496928adbd9d730f))
* update setting page, update profile page ([#390](https://github.com/lemonadesocial/lemonade-flutter/issues/390)) ([5f2124c](https://github.com/lemonadesocial/lemonade-flutter/commit/5f2124ce64df035c4b91efb3c88f367184c0e73c))

## [1.4.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.3.0...v1.4.0) (2024-02-01)


### Features

* check profile required fields before buying tickets ([#381](https://github.com/lemonadesocial/lemonade-flutter/issues/381)) ([aafbc34](https://github.com/lemonadesocial/lemonade-flutter/commit/aafbc3451f39ae61b96e5349afefecfe621fd973))


### Bug Fixes

* CTA button layout ([#383](https://github.com/lemonadesocial/lemonade-flutter/issues/383)) ([3a81421](https://github.com/lemonadesocial/lemonade-flutter/commit/3a8142100cf17c2cdba2a3e5f96c8087108e5eae))
* replace some mock data into real data of host event detail screen ([#385](https://github.com/lemonadesocial/lemonade-flutter/issues/385)) ([d5ff00b](https://github.com/lemonadesocial/lemonade-flutter/commit/d5ff00b2b5c126962b97f7c34f0555c014704068))
* show name in post comments ([#379](https://github.com/lemonadesocial/lemonade-flutter/issues/379)) ([ac737b0](https://github.com/lemonadesocial/lemonade-flutter/commit/ac737b09dd7fce2b078a2c0e0f4812a55925bef2))
* show wrong ticket price on buy ticket button ([#384](https://github.com/lemonadesocial/lemonade-flutter/issues/384)) ([fd6f0c4](https://github.com/lemonadesocial/lemonade-flutter/commit/fd6f0c4e3e77101e736fef0943b7580c21567d6e))
* support navigate to create event page in ai-chat ([#380](https://github.com/lemonadesocial/lemonade-flutter/issues/380)) ([a06fa80](https://github.com/lemonadesocial/lemonade-flutter/commit/a06fa80b16654d00d7a2decec7cfb05b92be504a))

## [1.3.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.2.0...v1.3.0) (2024-01-29)


### Features

* approve/decline join request, join request listing ([#370](https://github.com/lemonadesocial/lemonade-flutter/issues/370)) ([5b8eff0](https://github.com/lemonadesocial/lemonade-flutter/commit/5b8eff0d00e4e770d79033209bf83537bfb824bf))
<<<<<<< HEAD
* delete and edit reward ([#359](https://github.com/lemonadesocial/lemonade-flutter/issues/359)) ([8c692f3](https://github.com/lemonadesocial/lemonade-flutter/commit/8c692f30d6015013a2207e02ab75cc178ee8569d))
* implement show rewards info for guest ([#369](https://github.com/lemonadesocial/lemonade-flutter/issues/369)) ([5f57bc5](https://github.com/lemonadesocial/lemonade-flutter/commit/5f57bc56838506020ad4e36e4e2b7883e2903c09))
=======
* check my event join request ([#375](https://github.com/lemonadesocial/lemonade-flutter/issues/375)) ([ac7566d](https://github.com/lemonadesocial/lemonade-flutter/commit/ac7566d0e9b3f0b9f4dd8e629c27a06b739eacf3))
* delete and edit reward ([#359](https://github.com/lemonadesocial/lemonade-flutter/issues/359)) ([8c692f3](https://github.com/lemonadesocial/lemonade-flutter/commit/8c692f30d6015013a2207e02ab75cc178ee8569d))
* implement show rewards info for guest ([#369](https://github.com/lemonadesocial/lemonade-flutter/issues/369)) ([5f57bc5](https://github.com/lemonadesocial/lemonade-flutter/commit/5f57bc56838506020ad4e36e4e2b7883e2903c09))
* increase version code ([#372](https://github.com/lemonadesocial/lemonade-flutter/issues/372)) ([9bc54b3](https://github.com/lemonadesocial/lemonade-flutter/commit/9bc54b3e0e3ed2a0e8df4d71cbddd79d586de3b0))
>>>>>>> ec05a6021b497374f8bfd15c2f555be3c76123f3
* scan reward ([#365](https://github.com/lemonadesocial/lemonade-flutter/issues/365)) ([ccd1663](https://github.com/lemonadesocial/lemonade-flutter/commit/ccd16638ef167d77d42e1bfd2319b84889f374e1))


### Bug Fixes

* add published true when create event ([#362](https://github.com/lemonadesocial/lemonade-flutter/issues/362)) ([9ade0d6](https://github.com/lemonadesocial/lemonade-flutter/commit/9ade0d66d756fd1476f46ac543609bf2d2e3d011))
<<<<<<< HEAD
=======
* fix break layout in approval setting page ([#377](https://github.com/lemonadesocial/lemonade-flutter/issues/377)) ([1b205b8](https://github.com/lemonadesocial/lemonade-flutter/commit/1b205b82163b57ff94f20b2446d4fedd9c948562))
>>>>>>> ec05a6021b497374f8bfd15c2f555be3c76123f3
* update buy tickets api call flow ([#366](https://github.com/lemonadesocial/lemonade-flutter/issues/366)) ([ee31dd7](https://github.com/lemonadesocial/lemonade-flutter/commit/ee31dd7067c0a57eea06c6778ca1f88b5ed711d3))
* update placeholder text for create post screen ([#367](https://github.com/lemonadesocial/lemonade-flutter/issues/367)) ([21f7738](https://github.com/lemonadesocial/lemonade-flutter/commit/21f773850f5ee23e4e6b6473495cb08f4471c952))
* update redeem/buy tickets flow with new feature approval ([#363](https://github.com/lemonadesocial/lemonade-flutter/issues/363)) ([1f96b62](https://github.com/lemonadesocial/lemonade-flutter/commit/1f96b62b528ecd6030638475f306cc8de25400ac))

## [1.2.0](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.1.4...v1.2.0) (2024-01-19)


### Features

* add tickets control settings ([#351](https://github.com/lemonadesocial/lemonade-flutter/issues/351)) ([523a591](https://github.com/lemonadesocial/lemonade-flutter/commit/523a5912668c54656e9e577b944de79367cca23d))
* create event reward ([#357](https://github.com/lemonadesocial/lemonade-flutter/issues/357)) ([9d85433](https://github.com/lemonadesocial/lemonade-flutter/commit/9d854333ef167ff3bc4ed5b9f5740d3f1ff388ad))
* create ticket tier (erc20 prices only) ([#353](https://github.com/lemonadesocial/lemonade-flutter/issues/353)) ([1c77903](https://github.com/lemonadesocial/lemonade-flutter/commit/1c779035f229c77e3965e5bb45353908a8723e16))
* edit ticket tier ([#354](https://github.com/lemonadesocial/lemonade-flutter/issues/354)) ([7b97acd](https://github.com/lemonadesocial/lemonade-flutter/commit/7b97acd9a4c7a18437962457860893a0200da400))
* edit ticket tier prices ([#355](https://github.com/lemonadesocial/lemonade-flutter/issues/355)) ([7b1871b](https://github.com/lemonadesocial/lemonade-flutter/commit/7b1871b9f1aa39f754c4aeca28736a39c2f04a31))
* ticket tier modify actions ([#356](https://github.com/lemonadesocial/lemonade-flutter/issues/356)) ([f87f066](https://github.com/lemonadesocial/lemonade-flutter/commit/f87f0667cf7e3743cb343ac93397596ab5a0152b))


### Bug Fixes

* disable swipe drawer if unauthenticated ([#350](https://github.com/lemonadesocial/lemonade-flutter/issues/350)) ([ba0afd3](https://github.com/lemonadesocial/lemonade-flutter/commit/ba0afd32e6a7c5b06cbc4706cc15cb2aa2357f40))

## [1.1.4](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.1.3...v1.1.4) (2024-01-15)


### Bug Fixes

* enable accept term button by default in onboarding flow ([#348](https://github.com/lemonadesocial/lemonade-flutter/issues/348)) ([b7867e8](https://github.com/lemonadesocial/lemonade-flutter/commit/b7867e88b8af33276151392c31295e05f3c005fe))

## [1.1.3](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.1.2...v1.1.3) (2024-01-14)


### Bug Fixes

* update schemas ([#345](https://github.com/lemonadesocial/lemonade-flutter/issues/345)) ([f737691](https://github.com/lemonadesocial/lemonade-flutter/commit/f7376914accc99857d327cc115c796b8202dce24))

## [1.1.2](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.1.1...v1.1.2) (2024-01-12)


### Bug Fixes

* show error when network not supported stripe onramp ([#342](https://github.com/lemonadesocial/lemonade-flutter/issues/342)) ([8bffec8](https://github.com/lemonadesocial/lemonade-flutter/commit/8bffec88aacbb52cbc4eac12569428c2b5005d39))

## [1.1.1](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.1.0...v1.1.1) (2024-01-12)


### Bug Fixes

* use compute when generating seed from mnemonic ([#336](https://github.com/lemonadesocial/lemonade-flutter/issues/336)) ([680946a](https://github.com/lemonadesocial/lemonade-flutter/commit/680946a9c7251fa1d88487ead27734a43614e10c))

## [1.1.0-rc.1](https://github.com/lemonadesocial/lemonade-flutter/compare/v1.0.4-rc.1...v1.1.0-rc.1) (2024-01-11)


### Features

* cohosts & speakers management ([#324](https://github.com/lemonadesocial/lemonade-flutter/issues/324)) ([44fee72](https://github.com/lemonadesocial/lemonade-flutter/commit/44fee72d5782c668bae380e335b5e564da4ffd87))
* create ticket tier UI ([#326](https://github.com/lemonadesocial/lemonade-flutter/issues/326)) ([0d29f97](https://github.com/lemonadesocial/lemonade-flutter/commit/0d29f97a7f55fac71ceba82770458e2dc1d7fad9))
* display ticket tiers ([#327](https://github.com/lemonadesocial/lemonade-flutter/issues/327)) ([d84da54](https://github.com/lemonadesocial/lemonade-flutter/commit/d84da54fcea267130544b74957381734d96de4ee))
* event checkin ([#328](https://github.com/lemonadesocial/lemonade-flutter/issues/328)) ([554075b](https://github.com/lemonadesocial/lemonade-flutter/commit/554075bb69f2cc485ed54ea799c3c138e5fb8a07))


### Bug Fixes

* create event error ([#323](https://github.com/lemonadesocial/lemonade-flutter/issues/323)) ([ff9a498](https://github.com/lemonadesocial/lemonade-flutter/commit/ff9a49874a2e05535342478996526752789c6634))
* onramp webview not redirect, remove prepopulate topup amount ([#330](https://github.com/lemonadesocial/lemonade-flutter/issues/330)) ([461f74a](https://github.com/lemonadesocial/lemonade-flutter/commit/461f74af91ffba28759901b1fa035a2b40dc93f1))
* remove condition disabled redeem button ([#333](https://github.com/lemonadesocial/lemonade-flutter/issues/333)) ([265ab78](https://github.com/lemonadesocial/lemonade-flutter/commit/265ab78497bd3036e8de665d62b67154a7619dc1))
* remove order get hosting events ([#329](https://github.com/lemonadesocial/lemonade-flutter/issues/329)) ([95a72bf](https://github.com/lemonadesocial/lemonade-flutter/commit/95a72bf72f32d7ec0c761b3c207cd21dd7214400))
