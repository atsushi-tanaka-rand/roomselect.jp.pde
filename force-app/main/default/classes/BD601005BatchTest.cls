//自動メンテナンス差分バッチのテストクラス
@isTest
private class BD601005BatchTest {
    // 業者のレコードタイプID
    private static final Id     RECORDTYPE_ID_SUPPLIER = CommonUtil.getRecordTypeId('Account', CommonConst.ACCOUNT_RECTYPE_SUPPLIER);
    // メンテナンスコード
    private static final String BUILDING_MAINT_CODE    = 'BUILD';
    private static final String SUPPLIER_MAINT_CODE    = 'SUP-01';
    private static final String PROPERTY_MAINT_CODE    = 'PROP';
    // メンテナンスコード(既存)
    private static final String BUILDING_MAINT_CODE_EXISTS = 'BUILD_EXISTS'; 
    private static final String SUPPLIER_MAINT_CODE_EXISTS = 'SUP-EXISTS';
    private static final String PROPERTY_MAINT_CODE_EXISTS = 'PROP_EXISTS';

    // 自動メンテナンス差分　登録最大値
    private static final Integer AUTOMAINTEDIFF_ROOM_MAXCOUNT = 10;

    /** 自動メンテナンス差分 物件種別 */
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_MANSION            = 'マンション';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_APARTMENT          = 'アパート';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_DETACHEDHOUSE      = '一戸建て';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_TERRACEDHOUSE      = 'テラスハウス';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_TOWNHOUSE          = 'タウンハウス';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_SHAREHOUSE         = 'シェアハウス';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_DORMITORY_BOARDING = '寮・下宿';
    private static final String AUTOMAINTEDIFF_PROPERTYTYPE_OTHER              = 'その他';

    /** 自動メンテナンス差分 建物構造 */
    private static final String AUTOMAINTEDIFF_STRUCTURE_WOODEN           = '木造';
    private static final String AUTOMAINTEDIFF_STRUCTURE_BLOCK            = 'ブロック造';
    private static final String AUTOMAINTEDIFF_STRUCTURE_STEEL            = '鉄骨造';
    private static final String AUTOMAINTEDIFF_STRUCTURE_RC               = 'RC';
    private static final String AUTOMAINTEDIFF_STRUCTURE_SRC              = 'SRC';
    private static final String AUTOMAINTEDIFF_STRUCTURE_PC               = 'PC';
    private static final String AUTOMAINTEDIFF_STRUCTURE_HPC              = 'HPC';
    private static final String AUTOMAINTEDIFF_STRUCTURE_ALC              = 'ALC';
    private static final String AUTOMAINTEDIFF_STRUCTURE_LIGHTWEIGHTSTEEL = '軽量鉄骨';
    private static final String AUTOMAINTEDIFF_STRUCTURE_OTHER            = 'その他';

    /** 自動メンテナンス差分 管理人種別 */
    private static final String AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE    = '常駐';
    private static final String AUTOMAINTEDIFF_CARETAKERTYPE_NORESIDE  = '非常駐';
    private static final String AUTOMAINTEDIFF_CARETAKERTYPE_PATROL    = '巡回方式';
    private static final String AUTOMAINTEDIFF_CARETAKERTYPE_COMMUTER  = '通勤方式';

    /** 自動メンテナンス差分 バルコニー方向 */
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH      = '北';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_NORTHEAST  = '北東';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_EAST       = '東';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_SOUTHEAST  = '南東';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_SOUTH      = '南';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_SOUTHWEST  = '南西';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_WEST       = '西';
    private static final String AUTOMAINTEDIFF_BALCONYDIRECTION_NORTHWEST  = '北西';

    /** 自動メンテナンス差分 間取り */
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_R      = 'R';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_K      = 'K';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_DK     = 'DK';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_LK     = 'LK';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_LDK    = 'LDK';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_SK     = 'SK';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_SDK    = 'SDK';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_SLK    = 'SLK';
    private static final String AUTOMAINTEDIFF_ROOMLAYOUT_SLDK   = 'SLDK';

    /** 自動メンテナンス差分 現況 */
    private static final String AUTOMAINTEDIFF_LIVESTATUS_RESIDENT         = '居住中';
    private static final String AUTOMAINTEDIFF_LIVESTATUS_VACANCY          = '空室';
    private static final String AUTOMAINTEDIFF_LIVESTATUS_INCOMPLETE       = '未完成';
    private static final String AUTOMAINTEDIFF_LIVESTATUS_SCHEDULEDTOLEAVE = '退去予定';

    /** 自動メンテナンス差分 引渡種別 */
    private static final String AUTOMAINTEDIFF_DELIVERYTYPE_IMMEDIATE      = '即時';
    private static final String AUTOMAINTEDIFF_DELIVERYTYPE_CONSULTATION   = '相談';
    private static final String AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE        = '期日指定';

    /** 自動メンテナンス差分 引渡 月*/
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_JAN     = '1月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_FED     = '2月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_MAR     = '3月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_APR     = '4月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_MAY     = '5月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_JUN     = '6月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_JUL     = '7月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_AUG     = '8月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_SEP     = '9月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_OCT     = '10月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_NOV     = '11月';
    private static final String AUTOMAINTEDIFF_DELIVERYMONTH_DEC     = '12月';

    /** 自動メンテナンス差分 引渡 旬*/
    private static final String AUTOMAINTEDIFF_DELIVERYTIMING_EARLY      = '上旬';
    private static final String AUTOMAINTEDIFF_DELIVERYTIMING_MID        = '中旬';
    private static final String AUTOMAINTEDIFF_DELIVERYTIMING_LATE       = '下旬';

    /** 自動メンテナンス差分 各種料金単位 */
    private static final String AUTOMAINTEDIFF_FEEUNIT_YEN         = '円';
    private static final String AUTOMAINTEDIFF_FEEUNIT_MONTH       = 'ヵ月';
    private static final String AUTOMAINTEDIFF_FEEUNIT_RATE        = '%';
    private static final String AUTOMAINTEDIFF_FEEUNIT_ACTUALCOST  = '実費';

    /** 自動メンテナンス差分 各種税区分 */
    private static final String AUTOMAINTEDIFF_TAXTYPE_TAXABLE     = '課税';
    private static final String AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE   = '非課税';

    /** 自動メンテナンス差分 支払区分 */
    private static final String AUTOMAINTEDIFF_PAYMENTTYPE_MONTH = '月額';
    private static final String AUTOMAINTEDIFF_PAYMENTTYPE_YEAR  = '年額';
    private static final String AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY    = '入居前';
    private static final String AUTOMAINTEDIFF_PAYMENTTYPE_AFTER_OCCUPANCY     = '入居後';

    /** 自動メンテナンス差分 保証会社(利用区分) */
    private static final String AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED = '利用必須';
    private static final String AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_POSSIBLE = '利用可';

    /** 自動メンテナンス差分 駐車場種別 */
    private static final String AUTOMAINTEDIFF_PARKINGTYPE_EMPTY_EXISTS        = '空有';
    private static final String AUTOMAINTEDIFF_PARKINGTYPE_NO_EMPTY            = '空無';
    private static final String AUTOMAINTEDIFF_PARKINGTYPE_NO                  = '無';
    private static final String AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE = '近隣確保';

	// ▼2022/6/2 定数追加 大東建託連携
	/** 自動メンテナンス差分 未入居種別 */
	private static final String AUTOMAINTEDIFF_MOVEIN_EXISTS = '入居有';
	private static final String AUTOMAINTEDIFF_MOVEIN_NO	 = '未入居';
	// ▲2022/6/2

	// ▼2022/6/2 定数追加 大東建託連携
	/** 自動メンテナンス差分 特優賃料金変動区分 */
	private static final String AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_INCLINED = '傾斜型';
	private static final String AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT = 'フラット型';
	// ▲2022/6/2

	// ▼2022/6/30 定数追加 大東建託連携
	/** 自動メンテナンス差分 駐輪場種別 */
	private static final String AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS = '有';
	private static final String AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO = '無';
	// ▲2022/6/30

	// ▼2022/6/2 定数追加 大東建託連携
	/** 自動メンテナンス差分 バイク置場種別 */
	private static final String AUTOMAINTEDIFF_BIKEYARD_EXISTS = '有';
	private static final String AUTOMAINTEDIFF_BIKEYARD_NO = '無';
	// ▲2022/6/2 定数追加 大東建託連携

	// ▼2022/6/2 定数追加 大東建託連携
	/** 自動メンテナンス差分 広告料税区分 */
	private static final String AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED = '内税';
	private static final String AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_FOREIGNTAX = '外税';
	// ▲2022/6/2
	

    /** 自動メンテナンス差分 web公開 */
    private static final String AUTOMAINTEDIFF_WEBPUBLISHING_EXISTS    = 'する';
    private static final String AUTOMAINTEDIFF_WEBPUBLISHING_NO        = 'しない';

    /** システム変数　項目名 */
    private static final String IS_AUTOMAINTENANCE_BATCHPROCESSING  = CommonConst.IS_AUTOMAINTENANCE_BATCHPROCESSING; 
    private static final String IS_AUTOMAINTENANCE_BATCHPROCESSING2 = CommonConst.IS_AUTOMAINTENANCE_BATCHPROCESSING2; 
    private static final String IS_AUTOMAINTENANCE_BATCHPROCESSING3 = CommonConst.IS_AUTOMAINTENANCE_BATCHPROCESSING3; 
    private static final String IS_AUTOMAINTENANCE_BATCHPROCESSING4 = CommonConst.IS_AUTOMAINTENANCE_BATCHPROCESSING4; 
    private static final String IS_AUTOMAINTENANCE_BATCHPROCESSING5 = CommonConst.IS_AUTOMAINTENANCE_BATCHPROCESSING5; 

    /** 物件備考（非公開） */
    private static final String PROP_REMARKS_PRIVATE_INIT1    = '初期値1';
    private static final String PROP_REMARKS_PRIVATE_INIT2    = '初期値2';

    /** 設備備考（非公開） */
    private static final String FACILITY_REMARKS_PRIVATE_INIT1    = '初期値1';
    private static final String FACILITY_REMARKS_PRIVATE_INIT2    = '初期値2';

    /** 自動メンテナンス差分間取図ファイル名 */
    private static final String DIFF_ROOMLAYOUT_FILE_NAME_INIT1    = '初期値1';
    private static final String DIFF_ROOMLAYOUT_FILE_NAME_INIT2    = '初期値2';

    @TestSetup
    static void Setting(){
        //標準オブジェクト自動採番
        StandardObjectNumberSerial__c stdObjSerialAccount = new StandardObjectNumberSerial__c(
            ObjectApi__c = 'Account'      //オブジェクトAPI名
            ,Serial__c   = 1              //連番
            ,FieldApi__c = 'ForeignIDAutoNumber__c'//項目名
            ,Format__c = 'AFN-{0000000}'  //表示形式
        );
        Insert stdObjSerialAccount;

        // カスタム設定を登録 ※周辺施設取得Batchサイズ
        SystemConfig__c sysconf = new SystemConfig__c(
            SurroundingBatchProcessCount__c = 5
            ,AutoMaintenanceBatchProcessMaxCount__c = 200
        );
        insert sysconf;

        //システム変数オブジェクトを作成
        SystemVariables__c systemVariables = new SystemVariables__c(
            VariablesName__c = IS_AUTOMAINTENANCE_BATCHPROCESSING
            ,VariablesLabel__c = '自動メンテナンスバッチ処理中フラグ'
        );
        SystemVariables__c systemVariables2 = new SystemVariables__c(
            VariablesName__c = IS_AUTOMAINTENANCE_BATCHPROCESSING2
            ,VariablesLabel__c = '自動メンテナンスバッチ処理中フラグ2'
        );
        SystemVariables__c systemVariables3 = new SystemVariables__c(
            VariablesName__c = IS_AUTOMAINTENANCE_BATCHPROCESSING3
            ,VariablesLabel__c = '自動メンテナンスバッチ処理中フラグ3'
        );
        SystemVariables__c systemVariables4 = new SystemVariables__c(
            VariablesName__c = IS_AUTOMAINTENANCE_BATCHPROCESSING4
            ,VariablesLabel__c = '自動メンテナンスバッチ処理中フラグ4'
        );
        SystemVariables__c systemVariables5 = new SystemVariables__c(
            VariablesName__c = IS_AUTOMAINTENANCE_BATCHPROCESSING5
            ,VariablesLabel__c = '自動メンテナンスバッチ処理中フラグ5'
        );
        List <SystemVariables__c> systemVariablesList = new List<SystemVariables__c> {
            systemVariables,systemVariables2,systemVariables3,systemVariables4,systemVariables5
        };
        insert systemVariablesList;

        // 業者
        Account supplier = new Account(
            Name                        = '自動メンテナンス業者',
            recordTypeId                = RECORDTYPE_ID_SUPPLIER,
            MaintenanceSupplierCode__c  = SUPPLIER_MAINT_CODE_EXISTS,
            IsManagementCompany__c      = true
        );
        insert supplier;

        // 建物
        Building__c building = new Building__c(
            Name                       = '自動メンテナンス建物',
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE_EXISTS
        );
        insert building;

        // 物件
        Property__c prop = new Property__c(
            Building__c = building.Id,
            Name        = '自動メンテナンス物件',
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            FormerSupplier__c          = supplier.Id,
            AutoMaintenanceDiffRoomLayoutFileName__c = DIFF_ROOMLAYOUT_FILE_NAME_INIT1,
            RewardBurdenBorrower__c = 3.0, //報酬負担借主テスト用(2022/04/13追記)
            PropertyRemarksPrivate__c = PROP_REMARKS_PRIVATE_INIT1
        );
        insert prop;

        // 物件条件
        PropertyConditions__c propCond = new PropertyConditions__c(
            Property__c = prop.Id,
            FacilityRemarksPrivate__c = FACILITY_REMARKS_PRIVATE_INIT1,
            IsAirConditioner__c       = True
        );
        insert propCond;

        // 建物写真
        BuildingPhoto__c buildingPhoto = new BuildingPhoto__c(
            Building__c = building.Id
        );
        insert buildingPhoto;

        // 物件写真
        PropertyPhoto__c porpPhoto = new PropertyPhoto__c(
            Property__c = prop.Id
        );
        insert porpPhoto;

        // 部屋
        Room__c room = new Room__c(
            Property__c = prop.Id
        );
        insert room;
    }


    // 1:新規
    @isTest static void newRecord() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;


        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 業者データ登録値確認(新規登録)
    @isTest static void checkSupplierNewData() {
        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode    	= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
            BuildingName__c                 = '自動メンテ建物',
            PropertyName__c                 = '自動メンテ物件',
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 管理会社郵便番号　追加 大東建託連携
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 建物データ登録値確認(新規登録)
    @isTest static void checkBuildingNewData() {
        String BuildingName           = '自動メンテ建物名';                                 // 建物名
        String BuildKana              = 'ｼﾞﾄﾞｳﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
        String ChoazaCode             = '12345678901';                                      // 町字コード
        String State                  = '愛知県';                                           // 都道府県
		String postalCode			  = '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
        String City                   = '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
        String Street                 = '２１３−１';                                        // 住所２(番地)
        Decimal Latitude              = 35.169364;                                          // 緯度
        Decimal Longitude             = 137.002627;                                         // 経度
        String BuildingYM             = '200012';                                           // 築年月
        String PropertyType           = AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
        String Structure              = AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
        Decimal GroundFloorCount      = 100;                                                // 地上階数
        Decimal UndergroundFloorCount = 10;                                                 // 地下階数
        Decimal HouseCount            = 9999;                                               // 棟総戸数
        String CaretakerType          = AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
        String BuildingRemarksPrivate = '建物備考(非公開)';                                 // 建物備考(非公開)
        // 業者
        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;        


        // 自動メンテナンス差分データ作成
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
            PropertyName__c                 = '自動メンテ物件',
            BuildingName__c                 = BuildingName,
            BuildKana__c                    = BuildKana,
            ChoazaCode__c                   = ChoazaCode,
            State__c                        = State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
            City__c                         = City,
            Street__c                       = Street,
            Latitude__c                     = Latitude,
            Longitude__c                    = Longitude,
            BuildingYM__c                   = BuildingYM,
            PropertyType__c                 = PropertyType,
            Structure__c                    = Structure,
            GroundFloorCount__c             = GroundFloorCount,
            UndergroundFloorCount__c        = UndergroundFloorCount,
            HouseCount__c                   = HouseCount,
            CaretakerType__c                = CaretakerType,
            BuildingRemarksPrivate__c       = BuildingRemarksPrivate,
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );

        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 物件データ登録値確認(新規登録)
    @isTest static void checkPropertyNewData() {
        String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
        String propertyName = '自動メンテ物件';                                 // 部屋番号
        Decimal floor = 100;                                                    // 所在階
        String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;        //  バルコニー方向
        Decimal roomArea = 123.45;                                              // 専有面積
        Decimal balconyArea = 978.65;                                           // バルコニー面積
        Decimal roomCount = 99;                                                 // 部屋数
        String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;                        // 間取り
        String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;                 // 現況
        String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;              // 引渡種別
        String deliveryYear = '2020';                                           // 引渡 年
        String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN;                // 引渡 月
        String deliveryDay = '01';                                              // 引渡 日
        String deliveryTiming = null;                                           // 引渡 旬
        String propertyRemarksPrivate = '物件備考(非公開)';                     // 物件備考(非公開)
        Decimal rentFee = 1234567;                                              // 賃料
        Decimal managementFee = 123456;                                         // 管理費
        String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;           // 管理費税区分
        String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;                // 敷金単位
        Decimal securityDepositMonth = null;                                    // 敷金(ヶ月)
        Decimal securityDepositYen = 1111111;                                   // 敷金(円)
        String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;                       // 礼金単位
        Decimal keyMoneyMonth = null;                                           // 礼金(ヶ月)
        Decimal keyMoneyYen = 2222222;                                          // 礼金(円)
        String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;                        // 保証料金単位
        Decimal depositMonth = null;                                            // 保証料金(ヶ月)
        Decimal depositYen = 3333333;                                           // 保証料金(円)
        String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;          // 敷引・償却単位
        Decimal cancellationActualFeeMonth = null;                              // 敷引・償却(ヵ月)
        Decimal cancellationActualFeeRate = null;                               // 敷引・償却(%)
        Decimal cancellationActualFeeYen = 4444444;                             // 敷引・償却(円)
        Decimal renewalFeeMonth = null;                                         // 更新料(ヵ月)
        String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;                     // 更新料単位
        String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;              // 更新料税区分
        Decimal renewalFeeYen = 5555555;                                        // 更新料(円)
        Decimal keyExchangeFee = 666666;                                        // 鍵交換費
        String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;          // 鍵交換費税区分
        Decimal wortFee = 777777;                                               // 水道料金
        String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;                 // 水道料金税区分
        Decimal townshipFee = 888888;                                           // 町会費
        String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;             // 町会費税区分
        String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;       // 町会費支払区分
        Decimal CATVFee = 9999999;                                              // CATV
        String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;                    // CATV税区分
        Decimal cleaningFeeYen = 1111111;                                       // 定額修繕費(円)
        Decimal cleaningFeeMonth = null;                                        // 定額修繕費(ヵ月)
        String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;                    // 定額修繕費単位
        String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;             // 定額修繕費税区分
        String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;    // 定額修繕費支払区分
        String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED; // 保証会社(利用区分)
        String monetaryPrivate = '金銭備考(非公開)';                            // 金銭備考(非公開)
        String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;    // 駐車場種別
        Decimal parkingDistance = 22222;                                        // 近隣駐車場までの距離
        Decimal parkingFee = 333333;                                            // 駐車場料金
        String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;              // 駐車場料金税区分
        String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;          // 駐車場備考(非公開)
        String keyPlace = '鍵所在';                                             // 鍵所在
        Decimal rewardBurdenLender = 4.44;                                      // 報酬負担貸主
        Decimal rewardBurdenBorrower = 5.55;                                    // 報酬負担借主
        Decimal rewardSplitFormerSupplier = 6.66;                               // 報酬配分元付
        Decimal rewardSplitCustomer = 7.77;                                     // 報酬配分客付
        String ADRemarksPrivate = '広告備考(非公開)';                           // 広告備考(非公開)
        String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;                 // web公開　
        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;





        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
            BuildingName__c                 = '自動メンテ建物',
            PropertyName__c                 = propertyName,
            ExternalSiteCd__c               = externalSiteCd,
            Floor__c                        = floor,
            BalconyDirection__c             = balconyDirection,
            RoomArea__c                     = roomArea,
            BalconyArea__c                  = balconyArea,
            RoomCount__c                    = roomCount,
            RoomLayout__c                   = roomLayout,
            LiveStatus__c                   = liveStatus,
            DeliveryType__c                 = deliveryType,
            DeliveryYear__c                 = deliveryYear,
            DeliveryMonth__c                = deliveryMonth,
            DeliveryDay__c                  = deliveryDay,
            DeliveryTiming__c               = deliveryTiming,
            PropertyRemarksPrivate__c       = propertyRemarksPrivate,
            RentFee__c                      = rentFee,
            ManagementFee__c                = managementFee,
            ManagementFeeTaxType__c         = managementFeeTaxType,
            SecurityDepositUnit__c          = securityDepositUnit,
            SecurityDepositMonth__c         = securityDepositMonth,
            SecurityDepositYen__c           = securityDepositYen,
            KeyMoneyUnit__c                 = keyMoneyUnit,
            KeyMoneyMonth__c                = keyMoneyMonth,
            KeyMoneyYen__c                  = keyMoneyYen,
            DepositUnit__c                  = depositUnit,
            DepositMonth__c                 = depositMonth,
            DepositYen__c                   = depositYen,
            CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
            CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
            CancellationActualFeeRate__c    = cancellationActualFeeRate,
            CancellationActualFeeYen__c     = cancellationActualFeeYen,
            RenewalFeeMonth__c              = renewalFeeMonth,
            RenewalFeeUnit__c               = renewalFeeUnit,
            RenewalFeeTaxType__c            = renewalFeeTaxType,
            RenewalFeeYen__c                = renewalFeeYen,
            KeyExchangeFee__c               = keyExchangeFee,
            KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
            WortFee__c                      = wortFee,
            WortFeeTaxType__c               = wortFeeTaxType,
            TownshipFee__c                  = townshipFee,
            TownshipFeeTaxType__c           = townshipFeeTaxType,
            TownshipFeePaymentType__c       = townshipFeePaymentType,
            CATVFee__c                      = CATVFee,
            CATVTaxType__c                  = CATVTaxType,
            CleaningFeeYen__c               = cleaningFeeYen,
            CleaningFeeMonth__c             = cleaningFeeMonth,
            CleaningFeeUnit__c              = cleaningFeeUnit,
            CleaningFeeTaxType__c           = cleaningFeeTaxType,
            CleaningFeePaymentType__c       = cleaningFeePaymentType,
            GuaranteeidCompanyType__c       = guaranteeidCompanyType,
            MonetaryRemarksPrivate__c       = monetaryPrivate,
            ParkingType__c                  = parkingType,
            ParkingDistance__c              = parkingDistance,
            ParkingFee__c                   = parkingFee,
            ParkingFeeTaxType__c            = parkingFeeTaxType,
            ParkingRemarksPrivate__c        = parkingRemarksPrivate,
            KeyPlace__c                     = keyPlace,
            RewardBurdenLender__c           = rewardBurdenLender,
            RewardBurdenBorrower__c         = rewardBurdenBorrower,
            RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
            RewardSplitCustomer__c          = rewardSplitCustomer,
            ADRemarksPrivate__c             = ADRemarksPrivate,
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        // 登録値確認
        // 2021.02.25 Y.Hirata追加
        // AutoMaintenanceUtilの都道府県リストをシステム設定から取得するように変更したため、ここで登録値を確認する
        Account ac = [SELECT Id, State__c, City__c FROM Account WHERE Name = :supplierName LIMIT 1];
        System.assertEquals(supplierState, ac.State__c, '物件データ登録値確認(新規登録) 登録値確認：都道府県');
        System.assertEquals(supplierCity,  ac.City__c,  '物件データ登録値確認(新規登録) 登録値確認：住所１');
    }

    // 物件条件データ登録値確認（新規登録）
    @isTest static void checkPropCondNewData() {
        String facilityRemarksPrivate = '設備備考(非公開)';
        // 物件条件の作成（全てチェック）
        List<String> facilityApiList   = new List<String>();
        List<String> facilityLableList = new List<String>();
        Map<String, Schema.SObjectField> propCondFieldMap = Schema.getGlobalDescribe().get('grung__PropertyConditions__c').getDescribe().fields.getMap();
        Map<String, String> customCheckBoxFieldName = new Map<String, String>();
        for (String apiName : propCondFieldMap.keySet()) {
            // 項目定義情報取得
            Schema.SObjectField sof = propCondFieldMap.get(apiName);
            Boolean isCustom = sof.getDescribe().isCustom();        // カスタム項目フラグ
            Schema.DisplayType type = sof.getDescribe().getType();  // データ型
            // カスタムチェックボックス項目の、API名・表示名をMapに保持
            if (isCustom && type == Schema.DisplayType.BOOLEAN) {
                facilityApiList.add(apiName);
                facilityLableList.add(sof.getDescribe().getLabel());
            }
        }
        String facility = String.join(facilityLableList,';');

        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMeinteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            Facility__c                = facility,
            FacilityRemarksPrivate__c  = facilityRemarksPrivate,
            ExcecuteBatchNo__c         = 1
        );
        Insert autoMeinteDiff;


        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 部屋データ登録値確認（新規登録）
    @isTest static void checkRoomNewData() {
        // 登録値
        String roomType = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K;

        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            ExcecuteBatchNo__c         = 1
        );
        // 部屋設定
        for (Integer i = 1; i <= AUTOMAINTEDIFF_ROOM_MAXCOUNT; i++) {
            autoMainteDiff.put('grung__RoomType' + i + '__c', roomType);
            autoMainteDiff.put('grung__RoomFloorSpace' + i + '__c', i * 10.1);
        }

        // 自動メンテナンス差分作成（トリガー起動）
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 建物写真データ登録確認（新規）
    @isTest static void checkBuildingPhotoNewData() {
        String buildingPhotoFileName1  = '建物写真ファイル名1';
        String buildingPhotoFileName2  = '建物写真ファイル名2';
        String buildingPhotoFileName3  = '建物写真ファイル名3';
        String buildingPhotoFileName4  = '建物写真ファイル名4';
        String buildingPhotoFileName5  = '建物写真ファイル名5';
        String buildingPhotoFileName6  = '建物写真ファイル名6';
        String buildingPhotoFileName7  = '建物写真ファイル名7';
        String buildingPhotoFileName8  = '建物写真ファイル名8';
        String buildingPhotoFileName9  = '建物写真ファイル名9';
        String buildingPhotoFileName10 = '建物写真ファイル名10';
        String buildingTag1            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_APPEARANCE;         // 建物外観
        String buildingTag2            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_APPEARANCE_PARSE;   // 外観パース
        String buildingTag3            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_ENTRANCE;           // エントランス
        String buildingTag4            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_LOBBY;              // ロビー
        String buildingTag5            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_PARKING;            // 駐車場
        String buildingTag6            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_MAP;                // 地図
        String buildingTag7            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_OTHERSHARING;       // その他共有部分
        String buildingTag8            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_SURROUNDING;        // 周辺写真
        String buildingTag9            = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_SURROUNDING;        // 周辺写真
        String buildingTag10           = CommonConst.AUTOMAINTDIFF_BUILDINGPHOTOTAG_OTHER;              // その他
        String buildingComment1        = '建物写真コメント1';
        String buildingComment2        = '建物写真コメント2';
        String buildingComment3        = '建物写真コメント3';
        String buildingComment4        = '建物写真コメント4';
        String buildingComment5        = '建物写真コメント5';
        String buildingComment6        = '建物写真コメント6';
        String buildingComment7        = '建物写真コメント7';
        String buildingComment8        = '建物写真コメント8';
        String buildingComment9        = '建物写真コメント9';
        String buildingComment10       = '建物写真コメント10';


        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            BuildingPhotoFileName1__c  = buildingPhotoFileName1,
            BuildingPhotoFileName2__c  = buildingPhotoFileName2,
            BuildingPhotoFileName3__c  = buildingPhotoFileName3,
            BuildingPhotoFileName4__c  = buildingPhotoFileName4,
            BuildingPhotoFileName5__c  = buildingPhotoFileName5,
            BuildingPhotoFileName6__c  = buildingPhotoFileName6,
            BuildingPhotoFileName7__c  = buildingPhotoFileName7,
            BuildingPhotoFileName8__c  = buildingPhotoFileName8,
            BuildingPhotoFileName9__c  = buildingPhotoFileName9,
            BuildingPhotoFileName10__c = buildingPhotoFileName10,
            BuildingTag1__c            = buildingTag1,
            BuildingTag2__c            = buildingTag2,
            BuildingTag3__c            = buildingTag3,
            BuildingTag4__c            = buildingTag4,
            BuildingTag5__c            = buildingTag5,
            BuildingTag6__c            = buildingTag6,
            BuildingTag7__c            = buildingTag7,
            BuildingTag8__c            = buildingTag8,
            BuildingTag9__c            = buildingTag9,
            BuildingTag10__c           = buildingTag10,
            BuildingComment1__c        = buildingComment1,
            BuildingComment2__c        = buildingComment2,
            BuildingComment3__c        = buildingComment3,
            BuildingComment4__c        = buildingComment4,
            BuildingComment5__c        = buildingComment5,
            BuildingComment6__c        = buildingComment6,
            BuildingComment7__c        = buildingComment7,
            BuildingComment8__c        = buildingComment8,
            BuildingComment9__c        = buildingComment9,
            BuildingComment10__c       = buildingComment10,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 物件写真データ登録確認１（新規）※玄関まで
    @isTest static void checkPropertyPhotoNewData1() {
        String roomLayoutFileName  = '間取図ファイル';
        String propPhotoFileName1  = '物件写真ファイル名1';
        String propPhotoFileName2  = '物件写真ファイル名2';
        String propPhotoFileName3  = '物件写真ファイル名3';
        String propPhotoFileName4  = '物件写真ファイル名4';
        String propPhotoFileName5  = '物件写真ファイル名5';
        String propPhotoFileName6  = '物件写真ファイル名6';
        String propPhotoFileName7  = '物件写真ファイル名7';
        String propPhotoFileName8  = '物件写真ファイル名8';
        String propPhotoFileName9  = '物件写真ファイル名9';
        String propPhotoFileName10 = '物件写真ファイル名10';
        String roomLaoyoutTag      = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_ROOMLAYOUT; // 間取り
        String propPhotoTag1       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_LIVING;     // 居室・リビング
        String propPhotoTag2       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_OTHERROOM;  // その他部屋・スペース
        String propPhotoTag3       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_KITCHEN;    // キッチン
        String propPhotoTag4       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_BATH;       // バス・シャワールーム
        String propPhotoTag5       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_TOILET;     // トイレ
        String propPhotoTag6       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_WASHROOM;   // 洗面設備
        String propPhotoTag7       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_STORAGE;    // 収納
        String propPhotoTag8       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_BALCONY;    // バルコニー
        String propPhotoTag9       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_GARDEN;     // 庭
        String propPhotoTag10      = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_ENTRANCE;   // 玄関
        String propPhotoComment1   = '物件写真コメント1';
        String propPhotoComment2   = '物件写真コメント2';
        String propPhotoComment3   = '物件写真コメント3';
        String propPhotoComment4   = '物件写真コメント4';
        String propPhotoComment5   = '物件写真コメント5';
        String propPhotoComment6   = '物件写真コメント6';
        String propPhotoComment7   = '物件写真コメント7';
        String propPhotoComment8   = '物件写真コメント8';
        String propPhotoComment9   = '物件写真コメント9';
        String propPhotoComment10  = '物件写真コメント10';
        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;


        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            RoomLayoutFileName__c      = roomLayoutFileName,
            RoomLayoutTag__c           = roomLaoyoutTag,
            PropertyPhotoFileName1__c  = propPhotoFileName1,
            PropertyPhotoFileName2__c  = propPhotoFileName2,
            PropertyPhotoFileName3__c  = propPhotoFileName3,
            PropertyPhotoFileName4__c  = propPhotoFileName4,
            PropertyPhotoFileName5__c  = propPhotoFileName5,
            PropertyPhotoFileName6__c  = propPhotoFileName6,
            PropertyPhotoFileName7__c  = propPhotoFileName7,
            PropertyPhotoFileName8__c  = propPhotoFileName8,
            PropertyPhotoFileName9__c  = propPhotoFileName9,
            PropertyPhotoFileName10__c = propPhotoFileName10,
            PropertyTag1__c            = propPhotoTag1,
            PropertyTag2__c            = propPhotoTag2,
            PropertyTag3__c            = propPhotoTag3,
            PropertyTag4__c            = propPhotoTag4,
            PropertyTag5__c            = propPhotoTag5,
            PropertyTag6__c            = propPhotoTag6,
            PropertyTag7__c            = propPhotoTag7,
            PropertyTag8__c            = propPhotoTag8,
            PropertyTag9__c            = propPhotoTag9,
            PropertyTag10__c           = propPhotoTag10,
            PropertyComment1__c        = propPhotoComment1,
            PropertyComment2__c        = propPhotoComment2,
            PropertyComment3__c        = propPhotoComment3,
            PropertyComment4__c        = propPhotoComment4,
            PropertyComment5__c        = propPhotoComment5,
            PropertyComment6__c        = propPhotoComment6,
            PropertyComment7__c        = propPhotoComment7,
            PropertyComment8__c        = propPhotoComment8,
            PropertyComment9__c        = propPhotoComment9,
            PropertyComment10__c       = propPhotoComment10,
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
        
    }

    // 物件写真データ登録確認２（新規）※セキュリティ;その他設備;眺望;その他
    @isTest static void checkPropertyPhotoNewData2() {
        String propPhotoFileName1  = '物件写真ファイル名1';
        String propPhotoFileName2  = '物件写真ファイル名2';
        String propPhotoFileName3  = '物件写真ファイル名3';
        String propPhotoFileName4  = '物件写真ファイル名4';
        String propPhotoTag1       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_SECURITY;      // セキュリティ
        String propPhotoTag2       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_OTHERFACILITY; // その他設備
        String propPhotoTag3       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_VIEW;          // 眺望
        String propPhotoTag4       = CommonConst.AUTOMAINTEDIFF_PROPERTYPHOTOTAG_OTHER;         // その他
        String propPhotoComment1   = '物件写真コメント1';
        String propPhotoComment2   = '物件写真コメント2';
        String propPhotoComment3   = '物件写真コメント3';
        String propPhotoComment4   = '物件写真コメント4';
        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;        

        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            PropertyPhotoFileName1__c  = propPhotoFileName1,
            PropertyPhotoFileName2__c  = propPhotoFileName2,
            PropertyPhotoFileName3__c  = propPhotoFileName3,
            PropertyPhotoFileName4__c  = propPhotoFileName4,
            PropertyTag1__c            = propPhotoTag1,
            PropertyTag2__c            = propPhotoTag2,
            PropertyTag3__c            = propPhotoTag3,
            PropertyTag4__c            = propPhotoTag4,
            PropertyComment1__c        = propPhotoComment1,
            PropertyComment2__c        = propPhotoComment2,
            PropertyComment3__c        = propPhotoComment3,
            PropertyComment4__c        = propPhotoComment4,
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );
        insert autoMainteDiff;
        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 自動メンテナンス登録確認
    @isTest static void checkAutoMaintenanceNewData() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            ExternalSiteCd__c          = CommonConst.AUTOMAINTEDIFF_SITECODE_DAIWALIVING,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 条件変更
    @isTest static void changeConditions() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE_EXISTS,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 4:居住中→空室
    @isTest static void roomEmpty() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE_EXISTS,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE_EXISTS + '2',
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 5:掲載終了
    @isTest static void roomPostingEnd() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE_EXISTS,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 物件賃料項目　ヵ月
    @isTest static void propertyMoneyMonth() {
        String importType                   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd               = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;   // 外部サイトコード
        String propertyName                 = '自動メンテ物件';                                 // 部屋番号
        String deliveryType                 = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;              // 引渡種別
        String deliveryYear                 = '2020';                                           // 引渡 年
        String deliveryMonth                = AUTOMAINTEDIFF_DELIVERYMONTH_JAN;                 // 引渡 月
        String deliveryTiming               = AUTOMAINTEDIFF_DELIVERYTIMING_EARLY;              // 引渡 旬
        Decimal rentFee                     = 123456;                                           // 賃料
        String securityDepositUnit          = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 敷金単位
        Decimal securityDepositMonth        = 1.2;                                              // 敷金(ヶ月)
        String keyMoneyUnit                 = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 礼金単位
        Decimal keyMoneyMonth               = 3.4;                                              // 礼金(ヶ月)
        String depositUnit                  = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 保証料金単位
        Decimal depositMonth                = 5.6;                                              // 保証料金(ヶ月)
        String cancellationActualFeeUnit    = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 敷引・償却単位
        Decimal cancellationActualFeeMonth  = 7.8;                                              // 敷引・償却(ヵ月)
        Decimal renewalFeeMonth             = 9.0;                                              // 更新料(ヵ月)
        String renewalFeeUnit               = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 更新料単位
        String renewalFeeTaxType            = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;                   // 更新料税区分
        Decimal cleaningFeeMonth            = 11.2;                                             // 定額修繕費(ヵ月)
        String cleaningFeeUnit              = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 定額修繕費単位
        String cleaningFeeTaxType           = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;                   // 定額修繕費税区分
        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
            BuildingName__c                 = '自動メンテ建物',
            PropertyName__c                 = propertyName,
            ExternalSiteCd__c               = externalSiteCd,
            DeliveryType__c                 = deliveryType,
            DeliveryYear__c                 = deliveryYear,
            DeliveryMonth__c                = deliveryMonth,
            DeliveryTiming__c               = deliveryTiming,
            RentFee__c                      = rentFee,
            SecurityDepositUnit__c          = securityDepositUnit,
            SecurityDepositMonth__c         = securityDepositMonth,
            KeyMoneyUnit__c                 = keyMoneyUnit,
            KeyMoneyMonth__c                = keyMoneyMonth,
            DepositUnit__c                  = depositUnit,
            DepositMonth__c                 = depositMonth,
            CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
            CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
            RenewalFeeMonth__c              = renewalFeeMonth,
            RenewalFeeUnit__c               = renewalFeeUnit,
            RenewalFeeTaxType__c            = renewalFeeTaxType,
            CleaningFeeMonth__c             = cleaningFeeMonth,
            CleaningFeeUnit__c              = cleaningFeeUnit,
            CleaningFeeTaxType__c           = cleaningFeeTaxType,
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 物件データ登録値確認(新規登録)
    @isTest static void checkPropertyNewDataTEST() {
        String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
        String propertyName = '自動メンテ物件';                                 // 部屋番号
        Decimal floor = 100;                                                    // 所在階
        String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;        //  バルコニー方向
        Decimal roomArea = 123.45;                                              // 専有面積
        Decimal balconyArea = 978.65;                                           // バルコニー面積
        Decimal roomCount = 99;                                                 // 部屋数
        String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;                        // 間取り
        String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;                 // 現況
        String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;              // 引渡種別
        String deliveryYear = '2020';                                           // 引渡 年
        String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN;                // 引渡 月
        String deliveryDay = '01';                                              // 引渡 日
        String deliveryTiming = null;                                           // 引渡 旬
        String propertyRemarksPrivate = '物件備考(非公開)';                     // 物件備考(非公開)
        Decimal rentFee = 150000;                                              // 賃料
        Decimal managementFee = null;                                         // 管理費
        String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;           // 管理費税区分
        String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_MONTH;                // 敷金単位
        Decimal securityDepositMonth = 1.1;                                    // 敷金(ヶ月)        
        String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_MONTH;                       // 礼金単位
        Decimal keyMoneyMonth = 2.2;                                           // 礼金(ヶ月)
        String depositUnit = AUTOMAINTEDIFF_FEEUNIT_MONTH;                        // 保証料金単位
        Decimal depositMonth = 3.3;                                            // 保証料金(ヶ月)
        String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_MONTH;          // 敷引・償却単位
        Decimal cancellationActualFeeMonth = 4.4;                              // 敷引・償却(ヵ月)
        Decimal cancellationActualFeeRate = null;                               // 敷引・償却(%)
        Decimal renewalFeeMonth = 5.5;                                         // 更新料(ヵ月)
        String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_MONTH;                     // 更新料単位
        String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;              // 更新料税区分
        Decimal keyExchangeFee = 666666;                                        // 鍵交換費
        String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;          // 鍵交換費税区分
        Decimal wortFee = 777777;                                               // 水道料金
        String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;                 // 水道料金税区分
        Decimal townshipFee = 10000;                                           // 町会費
        String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;             // 町会費税区分
        String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;       // 町会費支払区分
        Decimal CATVFee = 1000;                                              // CATV
        String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;                    // CATV税区分
        Decimal cleaningFeeMonth = 6.6;                                        // 定額修繕費(ヵ月)
        String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_MONTH;                    // 定額修繕費単位
        String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;             // 定額修繕費税区分
        String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;    // 定額修繕費支払区分
        String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED; // 保証会社(利用区分)
        String monetaryPrivate = '金銭備考(非公開)';                            // 金銭備考(非公開)
        String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;    // 駐車場種別
        Decimal parkingDistance = 22222;                                        // 近隣駐車場までの距離
        Decimal parkingFee = 333333;                                            // 駐車場料金
        String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;              // 駐車場料金税区分
        String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;          // 駐車場備考(非公開)
        String keyPlace = '鍵所在';                                             // 鍵所在
        Decimal rewardBurdenLender = 4.44;                                      // 報酬負担貸主
        Decimal rewardBurdenBorrower = 5.55;                                    // 報酬負担借主
        Decimal rewardSplitFormerSupplier = 6.66;                               // 報酬配分元付
        Decimal rewardSplitCustomer = 7.77;                                     // 報酬配分客付
        String ADRemarksPrivate = '広告備考(非公開)';                           // 広告備考(非公開)
        String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;                 // web公開

        String supplierName             = '自動メンテ業者';
        String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
        String supplierState            = '愛知県';
        String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
        String supplierStreet           = null;
        String supplierPhone            = '052-726-3031';
        String supplierFax              = '052-726-3032';
        String supplierLicense          = '管理会社免許';
        String supplierStaffName        = '洞口 太郎';
        String supplierCompanyRemarks   = '管理会社備考';
        String supplierRemarks          = '';
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
        supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
        supplierRemarks += supplierCompanyRemarks;



        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
            MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
            BuildingName__c                 = '自動メンテ建物',
            PropertyName__c                 = propertyName,
            ExternalSiteCd__c               = externalSiteCd,
            Floor__c                        = floor,
            BalconyDirection__c             = balconyDirection,
            RoomArea__c                     = roomArea,
            BalconyArea__c                  = balconyArea,
            RoomCount__c                    = roomCount,
            RoomLayout__c                   = roomLayout,
            LiveStatus__c                   = liveStatus,
            DeliveryType__c                 = deliveryType,
            DeliveryYear__c                 = deliveryYear,
            DeliveryMonth__c                = deliveryMonth,
            DeliveryDay__c                  = deliveryDay,
            DeliveryTiming__c               = deliveryTiming,
            PropertyRemarksPrivate__c       = propertyRemarksPrivate,
            RentFee__c                      = rentFee,
            ManagementFee__c                = managementFee,
            ManagementFeeTaxType__c         = managementFeeTaxType,
            SecurityDepositUnit__c          = securityDepositUnit,
            SecurityDepositMonth__c         = securityDepositMonth,
            KeyMoneyUnit__c                 = keyMoneyUnit,
            KeyMoneyMonth__c                = keyMoneyMonth,
            DepositUnit__c                  = depositUnit,
            DepositMonth__c                 = depositMonth,
            CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
            CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
            CancellationActualFeeRate__c    = cancellationActualFeeRate,
            RenewalFeeMonth__c              = renewalFeeMonth,
            RenewalFeeUnit__c               = renewalFeeUnit,
            RenewalFeeTaxType__c            = renewalFeeTaxType,
            KeyExchangeFee__c               = keyExchangeFee,
            KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
            WortFee__c                      = wortFee,
            WortFeeTaxType__c               = wortFeeTaxType,
            TownshipFee__c                  = townshipFee,
            TownshipFeeTaxType__c           = townshipFeeTaxType,
            TownshipFeePaymentType__c       = townshipFeePaymentType,
            CATVFee__c                      = CATVFee,
            CATVTaxType__c                  = CATVTaxType,
            CleaningFeeMonth__c             = cleaningFeeMonth,
            CleaningFeeUnit__c              = cleaningFeeUnit,
            CleaningFeeTaxType__c           = cleaningFeeTaxType,
            CleaningFeePaymentType__c       = cleaningFeePaymentType,
            GuaranteeidCompanyType__c       = guaranteeidCompanyType,
            MonetaryRemarksPrivate__c       = monetaryPrivate,
            ParkingType__c                  = parkingType,
            ParkingDistance__c              = parkingDistance,
            ParkingFee__c                   = parkingFee,
            ParkingFeeTaxType__c            = parkingFeeTaxType,
            ParkingRemarksPrivate__c        = parkingRemarksPrivate,
            KeyPlace__c                     = keyPlace,
            RewardBurdenLender__c           = rewardBurdenLender,
            RewardBurdenBorrower__c         = rewardBurdenBorrower,
            RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
            RewardSplitCustomer__c          = rewardSplitCustomer,
            ADRemarksPrivate__c             = ADRemarksPrivate,
            ManagementCompanyName__c        = supplierName,
            ManagementCompanyAddress__c     = supplierAccress,
            ManagementCompanyPhone__c       = supplierPhone,
            ManagementCompanyFax__c         = supplierFax,
            ManagementCompanyLicense__c     = supplierLicense,
            ManagementCompanyStaffName__c   = supplierStaffName,
            ManagementCompanyRemarks__c     = supplierCompanyRemarks,
            ExcecuteBatchNo__c              = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }


    // 建物オブジェクトデータ取得
    private static List<Building__c> selectBuilding() {
        return selectBuilding(null);
    }
    private static List<Building__c> selectBuilding(String manteCode) {
        String sql = 'SELECT ' + getSelectAllField('Building__c') + ' FROM Building__c';
        if (!String.isEmpty(manteCode)) {
            sql += ' WHERE MaintenanceBuildingCode__c = :manteCode';
        }
        return Database.query(sql);
    }
    // 物件オブジェクトデータ取得
    private static List<Property__c> selectProperty() {
        return selectProperty(null);
    }
    private static List<Property__c> selectProperty(String mainteCode) {
        String sql = 'SELECT ' + getSelectAllField('Property__c') + ' FROM Property__c';
        if (!String.isEmpty(mainteCode)) {
            sql += ' WHERE MaintenancePropertyCode__c = :mainteCode';
        }
        return Database.query(sql);
    }
    // 建物写真オブジェクト　データ取得
    private static List<BuildingPhoto__c> selectBuildingPhoto() {
        return selectBuildingPhoto(null);
    }
    private static List<BuildingPhoto__c> selectBuildingPhoto(String mainteCode) {
        String sql = 'SELECT ' + getSelectAllField('BuildingPhoto__c') + ' FROM BuildingPhoto__c';
        if (!String.isEmpty(mainteCode)) {
            sql += ' WHERE Building__c IN (SELECT Id FROM Building__c WHERE MaintenanceBuildingCode__c = :mainteCode)';
        }
        return Database.query(sql);
    }
    // 物件写真オブジェクト データ取得
    private static List<PropertyPhoto__c> selectPropertyPhoto() {
        return selectPropertyPhoto(null);
    }
    private static List<PropertyPhoto__c> selectPropertyPhoto(String mainteCode) {
        String sql = 'SELECT ' + getSelectAllField('PropertyPhoto__c') + ' FROM PropertyPhoto__c';
        if (!String.isEmpty(mainteCode)) {
            sql += ' WHERE Property__c IN (SELECT Id FROM Property__c WHERE MaintenancePropertyCode__c = :mainteCode)';
        }
        return Database.query(sql);
    }
    // 部屋オブジェクト データ取得
    private static List<Room__c> selectRoom() {
        return selectRoom(null);
    }
    private static List<Room__c> selectRoom(String mainteCode) {
        String sql = 'SELECT ' + getSelectAllField('Room__c') + ' FROM Room__c';
        if (!String.isEmpty(mainteCode)) {
            sql += ' WHERE Property__c IN (SELECT Id FROM Property__c WHERE MaintenancePropertyCode__c = :mainteCode)';
        }
        sql += ' ORDER BY RoomFloorSpace__c';
        return Database.query(sql);
    }
    // 物件条件オブジェクト　データ取得
    private static List<PropertyConditions__c> selectPropertyConditions() {
        return selectPropertyConditions(null);
    }
    private static List<PropertyConditions__c> selectPropertyConditions(String mainteCode) {
        String sql = 'SELECT ' + getSelectAllField('PropertyConditions__c') + ' FROM PropertyConditions__c';
        if (!String.isEmpty(mainteCode)) {
            sql += ' WHERE Property__c IN (SELECT Id FROM Property__c WHERE MaintenancePropertyCode__c = :mainteCode)';
        }
        return Database.query(sql);
    }
    // 取引先オブジェクト　データ取得
    private static List<Account> selectAccount() {
        return selectAccount(null);
    }
    private static List<Account> selectAccount(String mainteCode) {
        String sql = 'SELECT ' + getSelectAllField('Account') + ' FROM Account';
        if (!String.isEmpty(mainteCode)) {
            sql += ' WHERE MaintenanceSupplierCode__c = :mainteCode';
        }
        return Database.query(sql);
    }
    // 自動メンテナンスオブジェクト　データ取得
    private static List<AutoMaintenance__c> selectAutoMainte() {
        String sql = 'SELECT ' + getSelectAllField('AutoMaintenance__c') + ' FROM AutoMaintenance__c';
        return Database.query(sql);
    }

    // 指定したオブジェクトの項目取得 ※,区切り
    private static String getSelectAllField(String objName){
        //項目名を区切る',' : 最初の項目の前には不要なため、初期値は空欄
        String commaString  = '';
        List<String> apiList = new List<String>();
        // SObject Describe
        Schema.DescribeSObjectResult obj = Schema.getGlobalDescribe().get(objName).getDescribe();
        // Fieldマップ取得
        Map<String, Schema.SObjectField> fieldMap = obj.fields.getMap();
        for (Schema.SObjectField item : fieldMap.values()) {
            apiList.add(item.getDescribe().getName());
        }
        return String.join(apiList, ',');
    }

    // 条件変更
    @isTest static void changeConditionsNotice() {
            
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
            ExternalSiteCd__c          = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE_EXISTS,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1,
            PropertyRemarksPrivate__c  = PROP_REMARKS_PRIVATE_INIT2,
            FacilityRemarksPrivate__c  = FACILITY_REMARKS_PRIVATE_INIT2,
            RoomLayoutFileName__c      = DIFF_ROOMLAYOUT_FILE_NAME_INIT2,
            ParkingType__c             = CommonConst.PROPERTY_PARKINGTYPE_NEIGHBORHOOD_SECURE,
            Facility__c                = 'メゾネット;'
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // 地区（エラー時）登録テスト
    @isTest static void RegistdistrictError() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE_EXISTS,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1,
            DepositMonth__c            = 1234567,
            ExternalSiteCd__c          = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO
        );
        insert autoMainteDiff;
    
        //バッチ実行
        AutoMaintenanceUtil.savePoint = GoogleApiUtil.savePoint;
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
    }

    // 1:新規（既存物件有り）
    @isTest static void newBuildingOldProperty() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c     = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c            = '自動メンテ建物',
            PropertyName__c            = '自動メンテ物件',
            ManagementCompanyName__c   = '自動メンテ業者',
            RoomType1__c               = CommonConst.AUTOMAINTEDIFF_ROOMTYPE_K,
            RoomFloorSpace1__c         = 10.0,
            ExcecuteBatchNo__c         = 1
        );
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    //▼ No.614 異常終了時の処理を追加
    /**
     * BD601005Batch
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance1Error() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        BD601005Batch.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }

    /**
     * BD601005Batch
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance1ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;
        
        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING);

        //バッチ実行
        Test.startTest();
        BD601005Batch batch = new BD601005Batch();
        BD601005Batch.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    /**
     * BD601005Batch_2
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance2Error() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(2,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch_2 batch = new BD601005Batch_2();
        BD601005Batch_2.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING2];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }

    /**
     * BD601005Batch_2
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance2ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(2,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;
        
        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING2);

        //バッチ実行
        Test.startTest();
        BD601005Batch_2 batch = new BD601005Batch_2();
        BD601005Batch_2.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    /**
     * BD601005Batch_3
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance3Error() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(3,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch_3 batch = new BD601005Batch_3();
        BD601005Batch_3.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING3];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }

    /**
     * BD601005Batch_3
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance3ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(3,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;
        
        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING3);

        //バッチ実行
        Test.startTest();
        BD601005Batch_3 batch = new BD601005Batch_3();
        BD601005Batch_3.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    /**
     * BD601005Batch_4
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance4Error() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(4,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch_4 batch = new BD601005Batch_4();
        BD601005Batch_4.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING4];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }

    /**
     * BD601005Batch_4
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance4ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(4,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;
        
        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING4);

        //バッチ実行
        Test.startTest();
        BD601005Batch_4 batch = new BD601005Batch_4();
        BD601005Batch_4.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    /**
     * BD601005Batch_5
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance5Error() {
        // 自動メンテナンス差分作成(トリガー起動)
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(5,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch_5 batch = new BD601005Batch_5();
        BD601005Batch_5.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING5];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }

    /**
     * BD601005Batch_5
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance5ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(5,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1);
        insert autoMainteDiff;
        
        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING5);

        //バッチ実行
        Test.startTest();
        BD601005Batch_5 batch = new BD601005Batch_5();
        BD601005Batch_5.isExceptionTest = true;
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }




    /**
     * BD601005Batch2
     * バッチ終了時
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance1Batch2Error() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch2 batch = new BD601005Batch2();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }
    
    /**
     * BD601005Batch2
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance1Batch2ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING);

        //バッチ実行
        Test.startTest();
        BD601005Batch2 batch = new BD601005Batch2();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    /**
     * BD601005Batch2_2
     * バッチ終了時
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance2Batch2Error() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(2,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch2_2 batch = new BD601005Batch2_2();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING2];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }
    
    /**
     * BD601005Batch2_2
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance2Batch2ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(2,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING2);

        //バッチ実行
        Test.startTest();
        BD601005Batch2_2 batch = new BD601005Batch2_2();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }
    /**
     * BD601005Batch2_3
     * バッチ終了時
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance3Batch2Error() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(3,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch2_3 batch = new BD601005Batch2_3();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING3];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }
    
    /**
     * BD601005Batch2_3
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance3Batch2ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(3,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING3);

        //バッチ実行
        Test.startTest();
        BD601005Batch2_3 batch = new BD601005Batch2_3();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }
    /**
     * BD601005Batch2_4
     * バッチ終了時
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance4Batch2Error() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(4,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch2_4 batch = new BD601005Batch2_4();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING4];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }
    
    /**
     * BD601005Batch2_4
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance4Batch2ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(4,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING4);

        //バッチ実行
        Test.startTest();
        BD601005Batch2_4 batch = new BD601005Batch2_4();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    /**
     * BD601005Batch2_5
     * バッチ終了時
     * システム変数の自動メンテナンスバッチ処理中フラグがFalseになること
     */
    @isTest static void autoMaintenance5Batch2Error() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(5,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        //バッチ実行
        Test.startTest();
        BD601005Batch2_5 batch = new BD601005Batch2_5();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        SystemVariables__c SystemVariablesData;
        SystemVariablesData = [SELECT Id ,BooleanValue__c FROM SystemVariables__c  WHERE VariablesName__c = :IS_AUTOMAINTENANCE_BATCHPROCESSING5];
        System.assertEquals(false,SystemVariablesData.BooleanValue__c);
    }
    
    /**
     * BD601005Batch2_5
     * バッチ終了時の例外エラー
     * システム変数の自動メンテナンスバッチ処理中フラグの更新がエラーになった際、メールがエラー送信先に送られること
     */
    @isTest static void autoMaintenance5Batch2ErrorMail() {
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = setAutoMaintenanceDifference(5,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_2);
        insert autoMainteDiff;

        // エラーメール用のシステム変数の変更
        changeSystemVariables(IS_AUTOMAINTENANCE_BATCHPROCESSING5);

        //バッチ実行
        Test.startTest();
        BD601005Batch2_5 batch = new BD601005Batch2_5();
        Database.executeBatch(batch, 1);
        Test.stopTest();
    }

    // ▼2022.04.07 No.0723 対応
    /**
    * １．自動メンテナンス区分1:新規
    * 　　実行された日付で物件の自社管理修正日にセットされないこと。
    * ２. 自動メンテナンス区分1:新規
    *     自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
    */
    @isTest static void AutomainteTest_kbn1(){
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = SetAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1,CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,'test');

        insert autoMainteDiff;
        //バッチ実行
        Test.startTest();
        BD601005Batch b = new BD601005Batch();
        Database.executeBatch(b, 1);
        Test.stopTest();

        //必要な情報を習得
        Property__c PropertyData = [SELECT CreatedDate, Id ,OwnCompanyManageModDate__c,RewardBurdenBorrower__c FROM Property__c order by CreatedDate desc Limit 1];
        // 実行された日付で物件の自社管理修正日にセットされないこと。
        System.assertEquals(null,PropertyData.OwnCompanyManageModDate__c);

        //自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
        System.assertEquals(1.0,PropertyData.RewardBurdenBorrower__c);
    }

     /**
    * １．自動メンテナンス区分2:物件新規
    * 　　実行された日付で物件の自社管理修正日にセットされないこと。
    * ２. 自動メンテナンス区分2:物件新規
    *     自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
    */
    @isTest static void AutomainteTest_kbn2(){
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = SetAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1,CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,'test');

        insert autoMainteDiff;
        //バッチ実行
        Test.startTest();
        BD601005Batch b = new BD601005Batch();
        Database.executeBatch(b, 1);
        Test.stopTest();

        //必要な情報を習得
        Property__c PropertyData = [SELECT CreatedDate, Id ,OwnCompanyManageModDate__c,RewardBurdenBorrower__c FROM Property__c order by CreatedDate desc Limit 1];
        // 実行された日付で物件の自社管理修正日にセットされないこと。
        System.assertEquals(null,PropertyData.OwnCompanyManageModDate__c);
        //自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
        System.assertEquals(1.0,PropertyData.RewardBurdenBorrower__c);
        
    }

    /**
    * １．自動メンテナンス区分3:条件変更
    * 　　実行された日付で物件の自社管理修正日にセットされること。
    * ２. 自動メンテナンス区分3:条件変更
    *     自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されないこと。
    */
    @isTest static void AutomainteTest_kbn3(){
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = SetAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1,CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,PROPERTY_MAINT_CODE_EXISTS);

        insert autoMainteDiff;
        //更新前にデータを取得し、保持 (2022/04/14 追記)
        Property__c PropertyData_before = [SELECT CreatedDate, Id ,OwnCompanyManageModDate__c,RewardBurdenBorrower__c FROM Property__c order by CreatedDate desc Limit 1];
        //バッチ実行
        Test.startTest();
        BD601005Batch b = new BD601005Batch();
        Database.executeBatch(b, 1);
        Test.stopTest();

        //必要な情報を習得 , 更新後のデータ取得(2022/04/13 追記)
         Property__c PropertyData_after = [SELECT CreatedDate, Id ,OwnCompanyManageModDate__c,RewardBurdenBorrower__c FROM Property__c order by CreatedDate desc Limit 1];
         // 実行された日付で物件の自社管理修正日にセットされること。
        System.assertEquals(CommonUtil.getNow().format('yyyy-mm-dd'),autoMainteDiff.InfoModifiedDate__c.format('yyyy-mm-dd'));//数秒差でエラーになるのでformat() 2022/04/13追記

        //自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されないこと。
        System.assertEquals(PropertyData_before.RewardBurdenBorrower__c,PropertyData_after.RewardBurdenBorrower__c);

    }

    /**
    * １．自動メンテナンス区分4:居住中→空室
    * 　　実行された日付で物件の自社管理修正日にセットされないこと。
    * ２. 自動メンテナンス区分4:居住中→空室
    *     自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
    */
    @isTest static void AutomainteTest_kbn4(){
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = SetAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1,CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,PROPERTY_MAINT_CODE_EXISTS);

        insert autoMainteDiff;
        //バッチ実行
        Test.startTest();
        BD601005Batch b = new BD601005Batch();
        Database.executeBatch(b, 1);
        Test.stopTest();

        //必要な情報を習得 
        Property__c PropertyData = [SELECT LastModifiedDate, Id ,OwnCompanyManageModDate__c,RewardBurdenBorrower__c  FROM Property__c order by LastModifiedDate desc Limit 1];
        // 実行された日付で物件の自社管理修正日にセットされないこと。
        System.assertEquals(null,PropertyData.OwnCompanyManageModDate__c);
        //自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
        System.assertEquals(1.0,PropertyData.RewardBurdenBorrower__c);
    }

    /**
    * １．自動メンテナンス区分5:掲載終了
    * 　　実行された日付で物件の自社管理修正日にセットされること。
    * ２. 自動メンテナンス区分5:
    *     自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されないこと。
    */
    @isTest static void AutomainteTest_kbn5(){
        // 自動メンテナンス差分作成
        t_auto_maintenance_difference__c autoMainteDiff = SetAutoMaintenanceDifference(1,CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1,CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,PROPERTY_MAINT_CODE_EXISTS);       

        insert autoMainteDiff;
        //バッチ実行
        Test.startTest();
        BD601005Batch b = new BD601005Batch();
        Database.executeBatch(b, 1);
        Test.stopTest();
        //必要な情報を習得 
         Property__c PropertyData = [SELECT CreatedDate, Id ,OwnCompanyManageModDate__c,RewardBurdenBorrower__c FROM Property__c order by CreatedDate desc Limit 1];
        
         // 実行された日付で物件の自社管理修正日にセットされること。
         System.assertEquals(CommonUtil.getNow().format('yyyy-mm-dd'),autoMainteDiff.InfoModifiedDate__c.format('yyyy-mm-dd'));//数秒差でエラーになるのでformat() 2022/04/13追記
        //自動メンテナンス差分の報酬負担借主の内容で物件の報酬負担借主に更新されること。
        System.assertNotEquals(1.0,PropertyData.RewardBurdenBorrower__c);
    }

    // テスト用自動メンテナンス差分作成 No0723用
    private static t_auto_maintenance_difference__c SetAutoMaintenanceDifference(Integer excecuteBatchNo,String batchStatus, String AutoMenteKbn, String MaintenancePropertyCode ) {
        return new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c      = AutoMenteKbn,
            MaintenanceBuildingCode__c  = BUILDING_MAINT_CODE_EXISTS,
            MaintenancePropertyCode__c  = MaintenancePropertyCode,
            MaintenanceSupplierCode__c  = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c             = '自動メンテ建物',
            PropertyName__c             = '自動メンテ物件',
            ManagementCompanyName__c    = '自動メンテ業者',
            ExternalSiteCd__c           = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO,    // 外部サイトコード
            InfoModifiedDate__c         = CommonUtil.getNow(), // 情報更新日
            RewardBurdenBorrower__c     = 1.0, //報酬負担借主
            ExcecuteBatchNo__c          = excecuteBatchNo,
            BatchStatus__c              = batchStatus
        );
    }
    // ▲2022.04.09 No.0723 対応

    // テスト用自動メンテナンス差分作成 1:新規
    private static t_auto_maintenance_difference__c setAutoMaintenanceDifference(Integer excecuteBatchNo,String batchStatus) {
        return new t_auto_maintenance_difference__c(
            AutoMaintenanceType__c      = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
            MaintenanceBuildingCode__c  = BUILDING_MAINT_CODE,
            MaintenancePropertyCode__c  = PROPERTY_MAINT_CODE_EXISTS,
            MaintenanceSupplierCode__c  = SUPPLIER_MAINT_CODE_EXISTS,
            BuildingName__c             = '自動メンテ建物',
            PropertyName__c             = '自動メンテ物件',
            ManagementCompanyName__c    = '自動メンテ業者',
            ExcecuteBatchNo__c          = excecuteBatchNo,
            BatchStatus__c              = batchStatus
        );
    }

	// システム設定エラー変更
	private static void changeSystemVariables(String variablesName) {
		SystemVariables__c SystemVariablesData;
		SystemVariablesData = [SELECT Id ,VariablesName__c FROM SystemVariables__c  WHERE VariablesName__c = :variablesName];
		SystemVariablesData.VariablesName__c = 'エラーになるよう';
		update SystemVariablesData;
	}
	//▲ No.614 異常終了時の処理を追加

	// ▼2022/5/31 大東建託連携 テストケース追加
	// 1:新規 リアプロ
	// 業者データ登録値確認(新規)
	@isTest static void checkSuppliersNewDataRealnetpro() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account 
			WHERE Name =:supplierName
			LIMIT 1 ];
		System.assertEquals(SUPPLIER_MAINT_CODE, ac.MaintenanceSupplierCode__c, '業者データリアプロ(新規) 登録値確認：メンテナンス業者コード');
        System.assertEquals(importType, ac.ImportType__c, '業者データリアプロ(新規) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データリアプロ(新規) 登録値確認：取引先名');
        System.assertEquals(null, ac.PostalCode__c, '業者データリアプロ(新規) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データリアプロ(新規) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データリアプロ(新規) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社免許:' + supplierLicense + CommonConst.BREAK_CODE + '管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データリアプロ(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データリアプロ(新規) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データリアプロ(新規) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データリアプロ(新規) 登録値確認：住所２');
	}

	// 1:新規 大東建託
	// 業者データ登録値確認(新規)
	@isTest static void checkSuppliersNewDataDaitoukentaku() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			State__c						= supplierState,		// 都道府県
			City__c							= supplierCity,			// 住所１
			Street__c						= supplierStreet,		// 住所２
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name =:supplierName
			LIMIT 1 ];
		System.assertEquals(SUPPLIER_MAINT_CODE, ac.MaintenanceSupplierCode__c, '業者データ大東建託(新規) 登録値確認：メンテナンス業者コード');
        System.assertEquals(importType, ac.ImportType__c, '業者データ大東建託(新規) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データ大東建託(新規) 登録値確認：取引先名');
        System.assertEquals(supplierPostalCode, ac.PostalCode__c, '業者データ大東建託(新規) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データ大東建託(新規) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データ大東建託(新規) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データ大東建託(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データ大東建託(新規) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データ大東建託(新規) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データ大東建託(新規) 登録値確認：住所２');
	}

	// 2:物件新規 リアプロ
	// 業者データ登録値確認（物件新規）
	@isTest static void checkSuppliersNewPropertyRealnetpro() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceRealnetpro();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name = '自動メンテ業者'
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account 
			WHERE Name =:supplierName
			LIMIT 1 ];
		System.assertEquals(SUPPLIER_MAINT_CODE, ac.MaintenanceSupplierCode__c, '業者データリアプロ(物件新規) 登録値確認：メンテナンス業者コード');
        System.assertEquals(importType, ac.ImportType__c, '業者データリアプロ(物件新規) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データリアプロ(物件新規) 登録値確認：取引先名');
        System.assertEquals(null, ac.PostalCode__c, '業者データリアプロ(物件新規) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データリアプロ(物件新規) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データリアプロ(物件新規) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社免許:' + supplierLicense + CommonConst.BREAK_CODE + '管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データリアプロ(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データリアプロ(物件新規) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データリアプロ(物件新規) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データリアプロ(物件新規) 登録値確認：住所２');
	}

	// 2:物件新規 大東建託
	// 業者データ登録値確認(物件新規)
	@isTest static void checkSuppliersNewPropertyDaitoukentaku() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceDaitoukentaku();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name = '自動メンテ業者'
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			State__c						= supplierState,		// 都道府県
			City__c							= supplierCity,			// 住所１
			Street__c						= supplierStreet,		// 住所２
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name =:supplierName
			LIMIT 1 ];
		System.assertEquals(SUPPLIER_MAINT_CODE, ac.MaintenanceSupplierCode__c, '業者データ大東建託(物件新規) 登録値確認：メンテナンス業者コード');
        System.assertEquals(importType, ac.ImportType__c, '業者データ大東建託(物件新規) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データ大東建託(物件新規) 登録値確認：取引先名');
        System.assertEquals(supplierPostalCode, ac.PostalCode__c, '業者データ大東建託(物件新規) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データ大東建託(物件新規) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データ大東建託(物件新規) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データ大東建託(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データ大東建託(物件新規) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データ大東建託(物件新規) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データ大東建託(物件新規) 登録値確認：住所２');
	}

    // 3:条件変更 リアプロ
	// 業者データ登録値確認（条件変更）
	@isTest static void checkSuppliersChangeConditionsRealnetpro() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceRealnetpro();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name = '自動メンテ業者'
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= 'リアプロ条件変更業者',
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name = '自動メンテ業者'
			LIMIT 1 ];
		System.assertEquals(SUPPLIER_MAINT_CODE, ac.MaintenanceSupplierCode__c, '業者データリアプロ(条件変更) 登録値確認：メンテナンス業者コード');
        System.assertEquals(importType, ac.ImportType__c, '業者データリアプロ(条件変更) 登録値確認：取込区分');
		System.assertEquals(ac_before.Name, ac.Name, '業者データリアプロ(条件変更) 登録値確認：取引先名');
        System.assertEquals(ac_before.PostalCode__c, ac.PostalCode__c, '業者データリアプロ(条件変更) 登録値確認：管理会社郵便番号');
		System.assertEquals(ac_before.Phone, ac.Phone, '業者データリアプロ(条件変更) 登録値確認：電話番号');
		System.assertEquals(ac_before.Fax, ac.Fax, '業者データリアプロ(条件変更) 登録値確認：FAX');
		System.assertEquals(ac_before.Representative__c, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals(ac_before.RemarksPrivate__c, ac.RemarksPrivate__c, '業者データリアプロ(新規) 登録値確認：備考（非公開）');
		System.assertEquals(ac_before.State__c, ac.State__c, '業者データリアプロ(条件変更) 登録値確認：都道府県');
		System.assertEquals(ac_before.City__c, ac.City__c, '業者データリアプロ(条件変更) 登録値確認：住所１');
		System.assertEquals(ac_before.Street__c, ac.Street__c, '業者データリアプロ(条件変更) 登録値確認：住所２');
	}

	// 3:条件変更 大東建託
	// 業者データ登録値確認(条件変更)
	@isTest static void checkSuppliersChangeConditionsDaitoukentaku() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceDaitoukentaku();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name = '自動メンテ業者'
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= '大東建託条件変更業者',
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE Name = '自動メンテ業者'
			LIMIT 1 ];
		System.assertEquals(SUPPLIER_MAINT_CODE, ac.MaintenanceSupplierCode__c, '業者データ大東建託(条件変更) 登録値確認：メンテナンス業者コード');
        System.assertEquals(importType, ac.ImportType__c, '業者データ大東建託(条件変更) 登録値確認：取込区分');
		System.assertEquals(ac_before.Name, ac.Name, '業者データ大東建託(条件変更) 登録値確認：取引先名');
        System.assertEquals(ac_before.PostalCode__c, ac.PostalCode__c, '業者データ大東建託(条件変更) 登録値確認：管理会社郵便番号');
		System.assertEquals(ac_before.Phone, ac.Phone, '業者データ大東建託(条件変更) 登録値確認：電話番号');
		System.assertEquals(ac_before.Fax, ac.Fax, '業者データ大東建託(条件変更) 登録値確認：FAX');
		System.assertEquals(ac_before.Representative__c, ac.Representative__c, '業者データ大東建託(新規) 登録値確認：取引先担当者');
		System.assertEquals(ac_before.RemarksPrivate__c, ac.RemarksPrivate__c, '業者データ大東建託(新規) 登録値確認：備考（非公開）');
		System.assertEquals(ac_before.State__c, ac.State__c, '業者データ大東建託(条件変更) 登録値確認：都道府県');
		System.assertEquals(ac_before.City__c, ac.City__c, '業者データ大東建託(条件変更) 登録値確認：住所１');
		System.assertEquals(ac_before.Street__c, ac.Street__c, '業者データ大東建託(条件変更) 登録値確認：住所２');
	}

    // 4:居住中→空室 リアプロ
	// 業者データ登録値確認（居住中→空室）
	@isTest static void checkSuppliersLivingChangeVacancyRealnetpro() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceRealnetpro();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許修正';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考修正';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account 
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(SUPPLIER_MAINT_CODE_EXISTS, ac.MaintenanceSupplierCode__c, '業者データリアプロ(居住中→空室) 登録値確認：メンテナンス業者コード');
        System.assertEquals(ac_before.ImportType__c, ac.ImportType__c, '業者データリアプロ(居住中→空室) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データリアプロ(居住中→空室) 登録値確認：取引先名');
        System.assertEquals(null, ac.PostalCode__c, '業者データリアプロ(居住中→空室) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データリアプロ(居住中→空室) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データリアプロ(居住中→空室) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社免許:' + supplierLicense + CommonConst.BREAK_CODE + '管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データリアプロ(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データリアプロ(居住中→空室) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データリアプロ(居住中→空室) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データリアプロ(居住中→空室) 登録値確認：住所２');
	}

	// 4:居住中→空室 大東建託
	// 業者データ登録値確認(居住中→空室)
	@isTest static void checkSuppliersLivingChangeVacancyDaitoukentaku() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceDaitoukentaku();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考修正';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account 
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(SUPPLIER_MAINT_CODE_EXISTS, ac.MaintenanceSupplierCode__c, '業者データ大東建託(居住中→空室) 登録値確認：メンテナンス業者コード');
        System.assertEquals(ac_before.ImportType__c, ac.ImportType__c, '業者データ大東建託(居住中→空室) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データ大東建託(居住中→空室) 登録値確認：取引先名');
        System.assertEquals(supplierPostalCode, ac.PostalCode__c, '業者データ大東建託(居住中→空室) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データ大東建託(居住中→空室) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データ大東建託(居住中→空室) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データ大東建託(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データ大東建託(居住中→空室) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データ大東建託(居住中→空室) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データ大東建託(居住中→空室) 登録値確認：住所２');
	}

	// 5:掲載終了 リアプロ
	// 業者データ登録値確認（掲載終了）
	@isTest static void checkSuppliersPostingEndRealnetpro() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceRealnetpro();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許修正';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考修正';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account 
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(SUPPLIER_MAINT_CODE_EXISTS, ac.MaintenanceSupplierCode__c, '業者データ大東建託(掲載終了) 登録値確認：メンテナンス業者コード');
        System.assertEquals(ac_before.ImportType__c, ac.ImportType__c, '業者データ大東建託(掲載終了) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データ大東建託(掲載終了) 登録値確認：取引先名');
        System.assertEquals(null, ac.PostalCode__c, '業者データ大東建託(掲載終了) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データ大東建託(掲載終了) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データ大東建託(掲載終了) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社免許:' + supplierLicense + CommonConst.BREAK_CODE + '管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データリアプロ(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データ大東建託(掲載終了) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データ大東建託(掲載終了) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データ大東建託(掲載終了) 登録値確認：住所２');
	}

	// 5:掲載終了 大東建託
	// 業者データ登録値確認(掲載終了)
	@isTest static void checkSuppliersPostingEndDaitoukentaku() {
		// 新規
		Account ac_AutoMainte = SetAutoMaintenanceDaitoukentaku();
		insert ac_AutoMainte;

		//更新前にデータを取得し、保持 
		Account ac_before= [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1 ];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考修正';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

        // 自動メンテナンス差分
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c					= '自動メンテ建物',
			PropertyName__c					= '自動メンテ物件',
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 管理会社郵便番号　追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 取引先(業者)の登録値を確認する
        Account ac = [
			SELECT 
				Id,
				MaintenanceSupplierCode__c,	// メンテナンス業者コード
				RecordTypeId,				// レコードタイプID
				ImportType__c,				// 取込区分
				Name,						// 取引先名
				PostalCode__c,				// 管理会社郵便番号
				Phone,						// 電話番号
				Fax,						// FAX
				Representative__c,			// 取引先担当者
				RemarksPrivate__c,			// 備考（非公開）
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c					// 住所２
			FROM Account 
			WHERE MaintenanceSupplierCode__c =:SUPPLIER_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(SUPPLIER_MAINT_CODE_EXISTS, ac.MaintenanceSupplierCode__c, '業者データ大東建託(掲載終了) 登録値確認：メンテナンス業者コード');
        System.assertEquals(ac_before.ImportType__c, ac.ImportType__c, '業者データ大東建託(掲載終了) 登録値確認：取込区分');
		System.assertEquals(supplierName, ac.Name, '業者データ大東建託(掲載終了) 登録値確認：取引先名');
        System.assertEquals(supplierPostalCode, ac.PostalCode__c, '業者データ大東建託(掲載終了) 登録値確認：管理会社郵便番号');
		System.assertEquals(supplierPhone, ac.Phone, '業者データ大東建託(掲載終了) 登録値確認：電話番号');
		System.assertEquals(supplierFax, ac.Fax, '業者データ大東建託(掲載終了) 登録値確認：FAX');
		System.assertEquals(supplierStaffName, ac.Representative__c, '業者データリアプロ(新規) 登録値確認：取引先担当者');
		System.assertEquals('管理会社備考:' + supplierCompanyRemarks, ac.RemarksPrivate__c, '業者データ大東建託(新規) 登録値確認：備考（非公開）');
		System.assertEquals(supplierState, ac.State__c, '業者データ大東建託(掲載終了) 登録値確認：都道府県');
		System.assertEquals(supplierCity, ac.City__c, '業者データ大東建託(掲載終了) 登録値確認：住所１');
		System.assertEquals(supplierStreet, ac.Street__c, '業者データ大東建託(掲載終了) 登録値確認：住所２');
	}

	// 1:新規 リアプロ
	// 建物データ登録値確認(新規)
	@isTest static void checkBuildingNewDataRealnetpro() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String BuildingName				= '自動メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾘｱﾌﾟﾛﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			PropertyName__c					= 'リアプロメンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE Name =:BuildingName
			LIMIT 1];
		System.assertEquals(BuildingName, bu.Name, '建物データリアプロ(新規) 登録値確認：建物名');
		System.assertEquals(BuildKana, bu.BuildKana__c, '建物データリアプロ(新規) 登録値確認：建物名カナ');
		System.assertEquals(BuildingYM, bu.BuildingYM__c, '建物データリアプロ(新規) 登録値確認：築年月');
		System.assertEquals(PropertyType, bu.PropertyType__c, '建物データリアプロ(新規) 登録値確認：物件種別');
		System.assertEquals(Structure, bu.Structure__c, '建物データリアプロ(新規) 登録値確認：建物構造');
		System.assertEquals(GroundFloorCount, bu.GroundFloorCount__c, '建物データリアプロ(新規) 登録値確認：地上階数');
		System.assertEquals(UndergroundFloorCount, bu.UndergroundFloorCount__c, '建物データリアプロ(新規) 登録値確認：地下階数');
		System.assertEquals(HouseCount, bu.HouseCount__c, '建物データリアプロ(新規) 登録値確認：棟総戸数');
		System.assertEquals(CaretakerType, bu.CaretakerType__c, '建物データリアプロ(新規) 登録値確認：管理人種別');
		System.assertEquals(importType, bu.ImportType__c, '建物データリアプロ(新規) 登録値確認：取込区分');
		System.assertEquals(BUILDING_MAINT_CODE, bu.MaintenanceBuildingCode__c, '建物データリアプロ(新規) 登録値確認：メンテナンス建物コード');
		System.assertEquals(ChoazaCode, bu.ChoazaCode__c, '建物データリアプロ(新規) 登録値確認：町字コード');
		System.assertEquals(null, bu.PostalCode__c,  '建物データリアプロ(新規) 登録値確認：郵便番号');
		System.assertEquals(State, bu.State__c,  '建物データリアプロ(新規) 登録値確認：都道府県');
		System.assertEquals(City, bu.City__c,  '建物データリアプロ(新規) 登録値確認：住所１');
		System.assertEquals(Street, bu.Street__c,  '建物データリアプロ(新規) 登録値確認：住所２');
		System.assertEquals(Latitude, bu.Latitude__c,  '建物データリアプロ(新規) 登録値確認：緯度');
		System.assertEquals(Longitude, bu.Longitude__c,  '建物データリアプロ(新規) 登録値確認：経度');
		System.assertEquals(false, bu.IsFirstSurroundingImportFlag__c, '建物データリアプロ(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(false, bu.IsWebCooperationAvailableFlag__c, '建物データリアプロ(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(BuildingRemarksPrivate, bu.BuildingRemarksPrivate__c,  '建物データリアプロ(新規) 登録値確認：建物備考');
		System.assertEquals(true, bu.IsMergeCompletedFlag__c, '建物データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 1:新規 大東建託
	// 建物データ登録値確認(新規)
	@isTest static void checkBuildingNewDataDaitoukentaku() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String BuildingName				= '大東建託メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾀﾞｲﾄｳｹﾝﾀｸﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			PropertyName__c					= '大東建託メンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE Name =:BuildingName
			LIMIT 1];
		System.assertEquals(BuildingName, bu.Name, '建物データ大東建託(新規) 登録値確認：建物名');
		System.assertEquals(BuildKana, bu.BuildKana__c, '建物データ大東建託(新規) 登録値確認：建物名カナ');
		System.assertEquals(BuildingYM, bu.BuildingYM__c, '建物データ大東建託(新規) 登録値確認：築年月');
		System.assertEquals(PropertyType, bu.PropertyType__c, '建物データ大東建託(新規) 登録値確認：物件種別');
		System.assertEquals(Structure, bu.Structure__c, '建物データ大東建託(新規) 登録値確認：建物構造');
		System.assertEquals(GroundFloorCount, bu.GroundFloorCount__c, '建物データ大東建託(新規) 登録値確認：地上階数');
		System.assertEquals(UndergroundFloorCount, bu.UndergroundFloorCount__c, '建物データ大東建託(新規) 登録値確認：地下階数');
		System.assertEquals(HouseCount, bu.HouseCount__c, '建物データ大東建託(新規) 登録値確認：棟総戸数');
		System.assertEquals(CaretakerType, bu.CaretakerType__c, '建物データ大東建託(新規) 登録値確認：管理人種別');
		System.assertEquals(importType, bu.ImportType__c, '建物データ大東建託(新規) 登録値確認：取込区分');
		System.assertEquals(BUILDING_MAINT_CODE, bu.MaintenanceBuildingCode__c, '建物データ大東建託(新規) 登録値確認：メンテナンス建物コード');
		System.assertEquals(ChoazaCode, bu.ChoazaCode__c, '建物データ大東建託(新規) 登録値確認：町字コード');
		System.assertEquals(postalCode, bu.PostalCode__c,  '建物データ大東建託(新規) 登録値確認：郵便番号');
		System.assertEquals(State, bu.State__c,  '建物データ大東建託(新規) 登録値確認：都道府県');
		System.assertEquals(City, bu.City__c,  '建物データ大東建託(新規) 登録値確認：住所１');
		System.assertEquals(Street, bu.Street__c,  '建物データ大東建託(新規) 登録値確認：住所２');
		System.assertEquals(Latitude, bu.Latitude__c,  '建物データ大東建託(新規) 登録値確認：緯度');
		System.assertEquals(Longitude, bu.Longitude__c,  '建物データ大東建託(新規) 登録値確認：経度');
		System.assertEquals(false, bu.IsFirstSurroundingImportFlag__c, '建物データ大東建託(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(false, bu.IsWebCooperationAvailableFlag__c, '建物データ大東建託(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(BuildingRemarksPrivate, bu.BuildingRemarksPrivate__c,  '建物データ大東建託(新規) 登録値確認：建物備考');
		System.assertEquals(true, bu.IsMergeCompletedFlag__c, '建物データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 2:物件新規 リアプロ
	// 建物データ登録値確認(物件新規)
	@isTest static void checkBuildingNewPropertyRealnetpro() {
		// 新規
		Building__c bu_AutoMainte = SetBuildibgAutoMaintenanceRealnetpro();
		insert bu_AutoMainte;

		//更新前にデータを取得し、保持 
		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String BuildingName				= '自動メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾘｱﾌﾟﾛﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			PropertyName__c					= 'リアプロメンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(BuildingName, bu.Name, '建物データリアプロ(物件新規) 登録値確認：建物名');
		System.assertEquals(BuildKana, bu.BuildKana__c, '建物データリアプロ(物件新規) 登録値確認：建物名カナ');
		System.assertEquals(BuildingYM, bu.BuildingYM__c, '建物データリアプロ(物件新規) 登録値確認：築年月');
		System.assertEquals(PropertyType, bu.PropertyType__c, '建物データリアプロ(物件新規) 登録値確認：物件種別');
		System.assertEquals(Structure, bu.Structure__c, '建物データリアプロ(物件新規) 登録値確認：建物構造');
		System.assertEquals(GroundFloorCount, bu.GroundFloorCount__c, '建物データリアプロ(物件新規) 登録値確認：地上階数');
		System.assertEquals(UndergroundFloorCount, bu.UndergroundFloorCount__c, '建物データリアプロ(物件新規) 登録値確認：地下階数');
		System.assertEquals(HouseCount, bu.HouseCount__c, '建物データリアプロ(物件新規) 登録値確認：棟総戸数');
		System.assertEquals(CaretakerType, bu.CaretakerType__c, '建物データリアプロ(物件新規) 登録値確認：管理人種別');
		System.assertEquals(bu_before.ImportType__c, bu.ImportType__c, '建物データリアプロ(物件新規) 登録値確認：取込区分');
		System.assertEquals(bu_before.MaintenanceBuildingCode__c, bu.MaintenanceBuildingCode__c, '建物データリアプロ(物件新規) 登録値確認：メンテナンス建物コード');
		System.assertEquals(bu_before.ChoazaCode__c, bu.ChoazaCode__c, '建物データリアプロ(物件新規) 登録値確認：町字コード');
		System.assertEquals(bu_before.PostalCode__c, bu.PostalCode__c,  '建物データリアプロ(物件新規) 登録値確認：郵便番号');
		System.assertEquals(bu_before.State__c, bu.State__c,  '建物データリアプロ(物件新規) 登録値確認：都道府県');
		System.assertEquals(bu_before.City__c, bu.City__c,  '建物データリアプロ(物件新規) 登録値確認：住所１');
		System.assertEquals(bu_before.Street__c, bu.Street__c,  '建物データリアプロ(物件新規) 登録値確認：住所２');
		System.assertEquals(bu_before.Latitude__c, bu.Latitude__c,  '建物データリアプロ(物件新規) 登録値確認：緯度');
		System.assertEquals(bu_before.Longitude__c, bu.Longitude__c,  '建物データリアプロ(物件新規) 登録値確認：経度');
		System.assertEquals(false, bu.IsFirstSurroundingImportFlag__c, '建物データリアプロ(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(false, bu.IsWebCooperationAvailableFlag__c, '建物データリアプロ(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(BuildingRemarksPrivate, bu.BuildingRemarksPrivate__c,  '建物データリアプロ(新規) 登録値確認：建物備考');
		System.assertEquals(true, bu.IsMergeCompletedFlag__c, '建物データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 2:物件新規 大東建託
	// 建物データ登録値確認(物件新規)
	@isTest static void checkBuildingNewPropertyDaitoukentaku() {
		// 新規
		Building__c bu_AutoMainte = SetBuildibgAutoMaintenanceDaitoukentaku();
		insert bu_AutoMainte;

		//更新前にデータを取得し、保持 

		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String BuildingName				= '大東建託メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾀﾞｲﾄｳｹﾝﾀｸﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			PropertyName__c					= '大東建託メンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(BuildingName, bu.Name, '建物データ大東建託(物件新規) 登録値確認：建物名');
		System.assertEquals(BuildKana, bu.BuildKana__c, '建物データ大東建託(物件新規) 登録値確認：建物名カナ');
		System.assertEquals(BuildingYM, bu.BuildingYM__c, '建物データ大東建託(物件新規) 登録値確認：築年月');
		System.assertEquals(PropertyType, bu.PropertyType__c, '建物データ大東建託(物件新規) 登録値確認：物件種別');
		System.assertEquals(Structure, bu.Structure__c, '建物データ大東建託(物件新規) 登録値確認：建物構造');
		System.assertEquals(GroundFloorCount, bu.GroundFloorCount__c, '建物データ大東建託(物件新規) 登録値確認：地上階数');
		System.assertEquals(UndergroundFloorCount, bu.UndergroundFloorCount__c, '建物データ大東建託(物件新規) 登録値確認：地下階数');
		System.assertEquals(HouseCount, bu.HouseCount__c, '建物データ大東建託(物件新規) 登録値確認：棟総戸数');
		System.assertEquals(CaretakerType, bu.CaretakerType__c, '建物データ大東建託(物件新規) 登録値確認：管理人種別');
		System.assertEquals(bu_before.ImportType__c, bu.ImportType__c, '建物データ大東建託(物件新規) 登録値確認：取込区分');
		System.assertEquals(bu_before.MaintenanceBuildingCode__c, bu.MaintenanceBuildingCode__c, '建物データ大東建託(物件新規) 登録値確認：メンテナンス建物コード');
		System.assertEquals(bu_before.ChoazaCode__c, bu.ChoazaCode__c, '建物データ大東建託(物件新規) 登録値確認：町字コード');
		System.assertEquals(bu_before.PostalCode__c, bu.PostalCode__c,  '建物データ大東建託(物件新規) 登録値確認：郵便番号');
		System.assertEquals(bu_before.State__c, bu.State__c,  '建物データ大東建託(物件新規) 登録値確認：都道府県');
		System.assertEquals(bu_before.City__c, bu.City__c,  '建物データ大東建託(物件新規) 登録値確認：住所１');
		System.assertEquals(bu_before.Street__c, bu.Street__c,  '建物データ大東建託(物件新規) 登録値確認：住所２');
		System.assertEquals(bu_before.Latitude__c, bu.Latitude__c,  '建物データ大東建託(物件新規) 登録値確認：緯度');
		System.assertEquals(bu_before.Longitude__c, bu.Longitude__c,  '建物データ大東建託(物件新規) 登録値確認：経度');
		System.assertEquals(false, bu.IsFirstSurroundingImportFlag__c, '建物データ大東建託(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(false, bu.IsWebCooperationAvailableFlag__c, '建物データ大東建託(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(BuildingRemarksPrivate, bu.BuildingRemarksPrivate__c,  '建物データ大東建託(新規) 登録値確認：建物備考');
		System.assertEquals(true, bu.IsMergeCompletedFlag__c, '建物データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 3:条件変更 リアプロ
	// 建物データ登録値確認(条件変更)
	@isTest static void checkBuildingChangeConditionsRealnetpro() {
		//新規 
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceRealnetpro();
        insert pr_AutoMainte;

		PropertyCodeHistory__c propertyCodeHistory = new PropertyCodeHistory__c(
			Property__c = pr_AutoMainte.Id,
            HistoryMaintenancePropertyCode__c = PROPERTY_MAINT_CODE
		);
		insert propertyCodeHistory;

		//更新前にデータを取得し、保持 
		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String BuildingName				= 'リアプロメンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾘｱﾌﾟﾛﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)修正';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			PropertyName__c					= 'リアプロメンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE
			LIMIT 1];
		System.assertEquals(bu_before.Name, bu.Name, '建物データリアプロ(条件変更) 登録値確認：建物名');
		System.assertEquals(bu_before.BuildKana__c, bu.BuildKana__c, '建物データリアプロ(条件変更) 登録値確認：建物名カナ');
		System.assertEquals(bu_before.BuildingYM__c, bu.BuildingYM__c, '建物データリアプロ(条件変更) 登録値確認：築年月');
		System.assertEquals(bu_before.PropertyType__c, bu.PropertyType__c, '建物データリアプロ(条件変更) 登録値確認：物件種別');
		System.assertEquals(bu_before.Structure__c, bu.Structure__c, '建物データリアプロ(条件変更) 登録値確認：建物構造');
		System.assertEquals(bu_before.GroundFloorCount__c, bu.GroundFloorCount__c, '建物データリアプロ(条件変更) 登録値確認：地上階数');
		System.assertEquals(bu_before.UndergroundFloorCount__c, bu.UndergroundFloorCount__c, '建物データリアプロ(条件変更) 登録値確認：地下階数');
		System.assertEquals(bu_before.HouseCount__c, bu.HouseCount__c, '建物データリアプロ(条件変更) 登録値確認：棟総戸数');
		System.assertEquals(bu_before.CaretakerType__c, bu.CaretakerType__c, '建物データリアプロ(条件変更) 登録値確認：管理人種別');
		System.assertEquals(bu_before.ImportType__c, bu.ImportType__c, '建物データリアプロ(条件変更) 登録値確認：取込区分');
		System.assertEquals(bu_before.MaintenanceBuildingCode__c, bu.MaintenanceBuildingCode__c, '建物データリアプロ(条件変更) 登録値確認：メンテナンス建物コード');
		System.assertEquals(bu_before.ChoazaCode__c, bu.ChoazaCode__c, '建物データリアプロ(条件変更) 登録値確認：町字コード');
		System.assertEquals(bu_before.PostalCode__c, bu.PostalCode__c,  '建物データリアプロ(条件変更) 登録値確認：郵便番号');
		System.assertEquals(bu_before.State__c, bu.State__c,  '建物データリアプロ(条件変更) 登録値確認：都道府県');
		System.assertEquals(bu_before.City__c, bu.City__c,  '建物データリアプロ(条件変更) 登録値確認：住所１');
		System.assertEquals(bu_before.Street__c, bu.Street__c,  '建物データリアプロ(条件変更) 登録値確認：住所２');
		System.assertEquals(bu_before.Latitude__c, bu.Latitude__c,  '建物データリアプロ(条件変更) 登録値確認：緯度');
		System.assertEquals(bu_before.Longitude__c, bu.Longitude__c,  '建物データリアプロ(条件変更) 登録値確認：経度');
		System.assertEquals(bu_before.IsFirstSurroundingImportFlag__c, bu.IsFirstSurroundingImportFlag__c, '建物データリアプロ(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(bu_before.IsWebCooperationAvailableFlag__c, bu.IsWebCooperationAvailableFlag__c, '建物データリアプロ(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(BuildingRemarksPrivate, bu.BuildingRemarksPrivate__c,  '建物データリアプロ(新規) 登録値確認：建物備考');
		System.assertEquals(bu_before.IsMergeCompletedFlag__c, bu.IsMergeCompletedFlag__c, '建物データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 3:条件変更 大東建託
	// 建物データ登録値確認(条件変更)
	@isTest static void checkBuildingChangeConditionsDaitoukentaku() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceDaitoukentaku();
        insert pr_AutoMainte;

		PropertyCodeHistory__c propertyCodeHistory = new PropertyCodeHistory__c(
			Property__c = pr_AutoMainte.Id,
            HistoryMaintenancePropertyCode__c = PROPERTY_MAINT_CODE
		);
		insert propertyCodeHistory;

		//更新前にデータを取得し、保持 

		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String BuildingName				= '大東建託メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾀﾞｲﾄｳｹﾝﾀｸﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			PropertyName__c					= '大東建託メンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE
			LIMIT 1];
		System.assertEquals(bu_before.Name, bu.Name, '建物データ大東建託(条件変更) 登録値確認：建物名');
		System.assertEquals(bu_before.BuildKana__c, bu.BuildKana__c, '建物データ大東建託(条件変更) 登録値確認：建物名カナ');
		System.assertEquals(bu_before.BuildingYM__c, bu.BuildingYM__c, '建物データ大東建託(条件変更) 登録値確認：築年月');
		System.assertEquals(bu_before.PropertyType__c, bu.PropertyType__c, '建物データ大東建託(条件変更) 登録値確認：物件種別');
		System.assertEquals(bu_before.Structure__c, bu.Structure__c, '建物データ大東建託(条件変更) 登録値確認：建物構造');
		System.assertEquals(bu_before.GroundFloorCount__c, bu.GroundFloorCount__c, '建物データ大東建託(条件変更) 登録値確認：地上階数');
		System.assertEquals(bu_before.UndergroundFloorCount__c, bu.UndergroundFloorCount__c, '建物データ大東建託(条件変更) 登録値確認：地下階数');
		System.assertEquals(bu_before.HouseCount__c, bu.HouseCount__c, '建物データ大東建託(条件変更) 登録値確認：棟総戸数');
		System.assertEquals(bu_before.CaretakerType__c, bu.CaretakerType__c, '建物データ大東建託(条件変更) 登録値確認：管理人種別');
		System.assertEquals(bu_before.ImportType__c, bu.ImportType__c, '建物データ大東建託(条件変更) 登録値確認：取込区分');
		System.assertEquals(bu_before.MaintenanceBuildingCode__c, bu.MaintenanceBuildingCode__c, '建物データ大東建託(条件変更) 登録値確認：メンテナンス建物コード');
		System.assertEquals(bu_before.ChoazaCode__c, bu.ChoazaCode__c, '建物データ大東建託(条件変更) 登録値確認：町字コード');
		System.assertEquals(bu_before.PostalCode__c, bu.PostalCode__c,  '建物データ大東建託(条件変更) 登録値確認：郵便番号');
		System.assertEquals(bu_before.State__c, bu.State__c,  '建物データ大東建託(条件変更) 登録値確認：都道府県');
		System.assertEquals(bu_before.City__c, bu.City__c,  '建物データ大東建託(条件変更) 登録値確認：住所１');
		System.assertEquals(bu_before.Street__c, bu.Street__c,  '建物データ大東建託(条件変更) 登録値確認：住所２');
		System.assertEquals(bu_before.Latitude__c, bu.Latitude__c,  '建物データ大東建託(条件変更) 登録値確認：緯度');
		System.assertEquals(bu_before.Longitude__c, bu.Longitude__c,  '建物データ大東建託(条件変更) 登録値確認：経度');
		System.assertEquals(bu_before.IsFirstSurroundingImportFlag__c, bu.IsFirstSurroundingImportFlag__c, '建物データ大東建託(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(bu_before.IsWebCooperationAvailableFlag__c, bu.IsWebCooperationAvailableFlag__c, '建物データ大東建託(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(BuildingRemarksPrivate, bu.BuildingRemarksPrivate__c,  '建物データ大東建託(新規) 登録値確認：建物備考');
		System.assertEquals(bu_before.IsMergeCompletedFlag__c, bu.IsMergeCompletedFlag__c, '建物データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 4:居住中→空室 リアプロ
	// 建物データ登録値確認(条件変更)
	@isTest static void checkBuildingLivingChangeVacancyRealnetpro() {
		// 新規
		Building__c bu_AutoMainte = SetBuildibgAutoMaintenanceRealnetpro();
		insert bu_AutoMainte;

		//更新前にデータを取得し、保持 
		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String BuildingName				= 'リアプロメンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾘｱﾌﾟﾛﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			PropertyName__c					= 'リアプロメンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= supplierRemarks,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(BuildingName, bu.Name, '建物データリアプロ(居住中→空室) 登録値確認：建物名');
		System.assertEquals(BuildKana, bu.BuildKana__c, '建物データリアプロ(居住中→空室) 登録値確認：建物名カナ');
		System.assertEquals(BuildingYM, bu.BuildingYM__c, '建物データリアプロ(居住中→空室) 登録値確認：築年月');
		System.assertEquals(PropertyType, bu.PropertyType__c, '建物データリアプロ(居住中→空室) 登録値確認：物件種別');
		System.assertEquals(Structure, bu.Structure__c, '建物データリアプロ(居住中→空室) 登録値確認：建物構造');
		System.assertEquals(GroundFloorCount, bu.GroundFloorCount__c, '建物データリアプロ(居住中→空室) 登録値確認：地上階数');
		System.assertEquals(UndergroundFloorCount, bu.UndergroundFloorCount__c, '建物データリアプロ(居住中→空室) 登録値確認：地下階数');
		System.assertEquals(HouseCount, bu.HouseCount__c, '建物データリアプロ(居住中→空室) 登録値確認：棟総戸数');
		System.assertEquals(CaretakerType, bu.CaretakerType__c, '建物データリアプロ(居住中→空室) 登録値確認：管理人種別');
		System.assertEquals(null, bu.ImportType__c, '建物データリアプロ(居住中→空室) 登録値確認：取込区分');
		System.assertEquals(BUILDING_MAINT_CODE_EXISTS, bu.MaintenanceBuildingCode__c, '建物データリアプロ(居住中→空室) 登録値確認：メンテナンス建物コード');
		System.assertEquals(null, bu.ChoazaCode__c, '建物データリアプロ(居住中→空室) 登録値確認：町字コード');
		System.assertEquals(null, bu.PostalCode__c,  '建物データリアプロ(居住中→空室) 登録値確認：郵便番号');
		System.assertEquals(null, bu.State__c,  '建物データリアプロ(居住中→空室) 登録値確認：都道府県');
		System.assertEquals(null, bu.City__c,  '建物データリアプロ(居住中→空室) 登録値確認：住所１');
		System.assertEquals(null, bu.Street__c,  '建物データリアプロ(居住中→空室) 登録値確認：住所２');
		System.assertEquals(null, bu.Latitude__c,  '建物データリアプロ(居住中→空室) 登録値確認：緯度');
		System.assertEquals(null, bu.Longitude__c,  '建物データリアプロ(居住中→空室) 登録値確認：経度');
		System.assertEquals(bu_before.IsFirstSurroundingImportFlag__c, bu.IsFirstSurroundingImportFlag__c, '建物データリアプロ(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(bu_before.IsWebCooperationAvailableFlag__c, bu.IsWebCooperationAvailableFlag__c, '建物データリアプロ(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(supplierRemarks, bu.BuildingRemarksPrivate__c,  '建物データリアプロ(新規) 登録値確認：建物備考');
		System.assertEquals(bu_before.IsMergeCompletedFlag__c, bu.IsMergeCompletedFlag__c, '建物データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 4:居住中→空室 大東建託
	// 建物データ登録値確認(条件変更)
	@isTest static void checkBuildingLivingChangeVacancyDaitoukentaku() {
		// 新規
		Building__c bu_AutoMainte = SetBuildibgAutoMaintenanceDaitoukentaku();
		insert bu_AutoMainte;

		//更新前にデータを取得し、保持 
		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String BuildingName				= '大東建託メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾀﾞｲﾄｳｹﾝﾀｸﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE_EXISTS,
			PropertyName__c					= '大東建託メンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= supplierRemarks,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(BuildingName, bu.Name, '建物データリアプロ(居住中→空室) 登録値確認：建物名');
		System.assertEquals(BuildKana, bu.BuildKana__c, '建物データリアプロ(居住中→空室) 登録値確認：建物名カナ');
		System.assertEquals(BuildingYM, bu.BuildingYM__c, '建物データリアプロ(居住中→空室) 登録値確認：築年月');
		System.assertEquals(PropertyType, bu.PropertyType__c, '建物データリアプロ(居住中→空室) 登録値確認：物件種別');
		System.assertEquals(Structure, bu.Structure__c, '建物データリアプロ(居住中→空室) 登録値確認：建物構造');
		System.assertEquals(GroundFloorCount, bu.GroundFloorCount__c, '建物データリアプロ(居住中→空室) 登録値確認：地上階数');
		System.assertEquals(UndergroundFloorCount, bu.UndergroundFloorCount__c, '建物データリアプロ(居住中→空室) 登録値確認：地下階数');
		System.assertEquals(HouseCount, bu.HouseCount__c, '建物データリアプロ(居住中→空室) 登録値確認：棟総戸数');
		System.assertEquals(CaretakerType, bu.CaretakerType__c, '建物データリアプロ(居住中→空室) 登録値確認：管理人種別');
		System.assertEquals(null, bu.ImportType__c, '建物データリアプロ(居住中→空室) 登録値確認：取込区分');
		System.assertEquals(BUILDING_MAINT_CODE_EXISTS, bu.MaintenanceBuildingCode__c, '建物データリアプロ(居住中→空室) 登録値確認：メンテナンス建物コード');
		System.assertEquals(null, bu.ChoazaCode__c, '建物データリアプロ(居住中→空室) 登録値確認：町字コード');
		System.assertEquals(null, bu.PostalCode__c,  '建物データリアプロ(居住中→空室) 登録値確認：郵便番号');
		System.assertEquals(null, bu.State__c,  '建物データリアプロ(居住中→空室) 登録値確認：都道府県');
		System.assertEquals(null, bu.City__c,  '建物データリアプロ(居住中→空室) 登録値確認：住所１');
		System.assertEquals(null, bu.Street__c,  '建物データリアプロ(居住中→空室) 登録値確認：住所２');
		System.assertEquals(null, bu.Latitude__c,  '建物データリアプロ(居住中→空室) 登録値確認：緯度');
		System.assertEquals(null, bu.Longitude__c,  '建物データリアプロ(居住中→空室) 登録値確認：経度');
		System.assertEquals(bu_before.IsFirstSurroundingImportFlag__c, bu.IsFirstSurroundingImportFlag__c, '建物データ大東建託(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(bu_before.IsWebCooperationAvailableFlag__c, bu.IsWebCooperationAvailableFlag__c, '建物データ大東建託(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(supplierRemarks, bu.BuildingRemarksPrivate__c,  '建物データ大東建託(新規) 登録値確認：建物備考');
		System.assertEquals(bu_before.IsMergeCompletedFlag__c, bu.IsMergeCompletedFlag__c, '建物データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 5:掲載終了 リアプロ
	// 建物データ登録値確認(条件変更)
	@isTest static void checkBuildingPostingEndRealnetpro() {
		// 新規
		Building__c bu_AutoMainte = SetBuildibgAutoMaintenanceRealnetpro();
		insert bu_AutoMainte;

		//更新前にデータを取得し、保持 
		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String BuildingName				= '自動メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾘｱﾌﾟﾛﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			PropertyName__c					= 'リアプロメンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(bu_before.Name, bu.Name, '建物データリアプロ(掲載終了) 登録値確認：建物名');
		System.assertEquals(bu_before.BuildKana__c, bu.BuildKana__c, '建物データリアプロ(掲載終了) 登録値確認：建物名カナ');
		System.assertEquals(bu_before.BuildingYM__c, bu.BuildingYM__c, '建物データリアプロ(掲載終了) 登録値確認：築年月');
		System.assertEquals(bu_before.PropertyType__c, bu.PropertyType__c, '建物データリアプロ(掲載終了) 登録値確認：物件種別');
		System.assertEquals(bu_before.Structure__c, bu.Structure__c, '建物データリアプロ(掲載終了) 登録値確認：建物構造');
		System.assertEquals(bu_before.GroundFloorCount__c, bu.GroundFloorCount__c, '建物データリアプロ(掲載終了) 登録値確認：地上階数');
		System.assertEquals(bu_before.UndergroundFloorCount__c, bu.UndergroundFloorCount__c, '建物データリアプロ(掲載終了) 登録値確認：地下階数');
		System.assertEquals(bu_before.HouseCount__c, bu.HouseCount__c, '建物データリアプロ(掲載終了) 登録値確認：棟総戸数');
		System.assertEquals(bu_before.CaretakerType__c, bu.CaretakerType__c, '建物データリアプロ(掲載終了) 登録値確認：管理人種別');
		System.assertEquals(bu_before.ImportType__c, bu.ImportType__c, '建物データリアプロ(掲載終了) 登録値確認：取込区分');
		System.assertEquals(bu_before.MaintenanceBuildingCode__c, bu.MaintenanceBuildingCode__c, '建物データリアプロ(掲載終了) 登録値確認：メンテナンス建物コード');
		System.assertEquals(bu_before.ChoazaCode__c, bu.ChoazaCode__c, '建物データリアプロ(掲載終了) 登録値確認：町字コード');
		System.assertEquals(bu_before.PostalCode__c, bu.PostalCode__c,  '建物データリアプロ(掲載終了) 登録値確認：郵便番号');
		System.assertEquals(bu_before.State__c, bu.State__c,  '建物データリアプロ(掲載終了) 登録値確認：都道府県');
		System.assertEquals(bu_before.City__c, bu.City__c,  '建物データリアプロ(掲載終了) 登録値確認：住所１');
		System.assertEquals(bu_before.Street__c, bu.Street__c,  '建物データリアプロ(掲載終了) 登録値確認：住所２');
		System.assertEquals(bu_before.Latitude__c, bu.Latitude__c,  '建物データリアプロ(掲載終了) 登録値確認：緯度');
		System.assertEquals(bu_before.Longitude__c, bu.Longitude__c,  '建物データリアプロ(掲載終了) 登録値確認：経度');
		System.assertEquals(bu_before.IsFirstSurroundingImportFlag__c, bu.IsFirstSurroundingImportFlag__c, '建物データリアプロ(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(bu_before.IsWebCooperationAvailableFlag__c, bu.IsWebCooperationAvailableFlag__c, '建物データリアプロ(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(bu_before.BuildingRemarksPrivate__c, bu.BuildingRemarksPrivate__c,  '建物データリアプロ(掲載終了) 登録値確認：建物備考');
		System.assertEquals(bu_before.IsMergeCompletedFlag__c, bu.IsMergeCompletedFlag__c, '建物データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
	}

	// 5:掲載終了 大東建託
	// 建物データ登録値確認(掲載終了)
	@isTest static void checkBuildingPostingEndDaitoukentaku() {
		// 新規
		Building__c bu_AutoMainte = SetBuildibgAutoMaintenanceDaitoukentaku();
		insert bu_AutoMainte;

		//更新前にデータを取得し、保持 
		Building__c bu_before= [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];

		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String BuildingName				= '大東建託メンテ建物名';                                 // 建物名
		String BuildKana				= 'ﾀﾞｲﾄｳｹﾝﾀｸﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '12345678901';                                      // 町字コード
		String State					= '愛知県';                                           // 都道府県
		String postalCode				= '123-4567';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '名古屋市名東区上社１丁目';                         // 住所１(市区町村)
		String Street					= '２１３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169364;                                          // 緯度
		Decimal Longitude				= 137.002627;                                         // 経度
		String BuildingYM				= '200012';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_MANSION;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_WOODEN;                    // 建物構造
		Decimal GroundFloorCount		= 100;                                                // 地上階数
		Decimal UndergroundFloorCount	= 10;                                                 // 地下階数
		Decimal HouseCount				= 9999;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_RESIDE;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;        


		// 自動メンテナンス差分データ作成
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			ExternalSiteCd__c				= externalSiteCd,
			AutoMaintenanceType__c			= CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c		= PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			PropertyName__c					= '大東建託メンテ物件',
			BuildingName__c					= BuildingName,
			BuildKana__c					= BuildKana,
			ChoazaCode__c					= ChoazaCode,
			State__c						= State,
			PostalCode__c					= postalCode,	// 2022/5/27 項目追加 大東建託連携
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			BuildingRemarksPrivate__c		= BuildingRemarksPrivate,
			ManagementCompanyName__c		= supplierName,
			ManagementCompanyAddress__c		= supplierAccress,
			ManagementCompanyPostalCode__c	= supplierPostalCode,	// 2022/5/27 項目追加 大東建託連携
			ManagementCompanyPhone__c		= supplierPhone,
			ManagementCompanyFax__c			= supplierFax,
			ManagementCompanyLicense__c		= supplierLicense,
			ManagementCompanyStaffName__c	= supplierStaffName,
			ManagementCompanyRemarks__c		= supplierCompanyRemarks,
			ExcecuteBatchNo__c				= 1
		);

		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 建物オブジェクトの登録値を確認する
		Building__c bu = [
			SELECT
				Id,
				Name,						// 建物名
				BuildKana__c,				// 建物名カナ
				BuildingYM__c,				// 築年月
				PropertyType__c,			// 物件種別
				Structure__c,				// 建物構造
				GroundFloorCount__c,		// 地上階数
				UndergroundFloorCount__c,	// 地下階数
				HouseCount__c,				// 棟総戸数
				CaretakerType__c,			// 管理人種別
				ImportType__c,				// 取込区分
				MaintenanceBuildingCode__c,	// メンテナンス建物コード
				ChoazaCode__c,				// 町字コード
				PostalCode__c,				// 郵便番号
				State__c,					// 都道府県
				City__c,					// 住所１
				Street__c,					// 住所２
				Latitude__c,				// 緯度
				Longitude__c,				// 経度
				IsFirstSurroundingImportFlag__c,	// 初回周辺取込フラグ
				IsWebCooperationAvailableFlag__c,	// Web連携可能フラグ
				BuildingRemarksPrivate__c,	// 建物備考(非公開)
				IsMergeCompletedFlag__c		// 名寄せ完了フラグ
			FROM Building__c 
			WHERE MaintenanceBuildingCode__c =:BUILDING_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(bu_before.Name, bu.Name, '建物データ大東建託(掲載終了) 登録値確認：建物名');
		System.assertEquals(bu_before.BuildKana__c, bu.BuildKana__c, '建物データ大東建託(掲載終了) 登録値確認：建物名カナ');
		System.assertEquals(bu_before.BuildingYM__c, bu.BuildingYM__c, '建物データ大東建託(掲載終了) 登録値確認：築年月');
		System.assertEquals(bu_before.PropertyType__c, bu.PropertyType__c, '建物データ大東建託(掲載終了) 登録値確認：物件種別');
		System.assertEquals(bu_before.Structure__c, bu.Structure__c, '建物データ大東建託(掲載終了) 登録値確認：建物構造');
		System.assertEquals(bu_before.GroundFloorCount__c, bu.GroundFloorCount__c, '建物データ大東建託(掲載終了) 登録値確認：地上階数');
		System.assertEquals(bu_before.UndergroundFloorCount__c, bu.UndergroundFloorCount__c, '建物データ大東建託(掲載終了) 登録値確認：地下階数');
		System.assertEquals(bu_before.HouseCount__c, bu.HouseCount__c, '建物データ大東建託(掲載終了) 登録値確認：棟総戸数');
		System.assertEquals(bu_before.CaretakerType__c, bu.CaretakerType__c, '建物データ大東建託(掲載終了) 登録値確認：管理人種別');
		System.assertEquals(bu_before.ImportType__c, bu.ImportType__c, '建物データ大東建託(掲載有料) 登録値確認：取込区分');
		System.assertEquals(bu_before.MaintenanceBuildingCode__c, bu.MaintenanceBuildingCode__c, '建物データ大東建託(掲載終了) 登録値確認：メンテナンス建物コード');
		System.assertEquals(bu_before.ChoazaCode__c, bu.ChoazaCode__c, '建物データ大東建託(掲載終了) 登録値確認：町字コード');
		System.assertEquals(bu_before.PostalCode__c, bu.PostalCode__c,  '建物データ大東建託(掲載終了) 登録値確認：郵便番号');
		System.assertEquals(bu_before.State__c, bu.State__c,  '建物データ大東建託(掲載終了) 登録値確認：都道府県');
		System.assertEquals(bu_before.City__c, bu.City__c,  '建物データ大東建託(掲載終了) 登録値確認：住所１');
		System.assertEquals(bu_before.Street__c, bu.Street__c,  '建物データ大東建託(掲載終了) 登録値確認：住所２');
		System.assertEquals(bu_before.Latitude__c, bu.Latitude__c,  '建物データ大東建託(掲載終了) 登録値確認：緯度');
		System.assertEquals(bu_before.Longitude__c, bu.Longitude__c,  '建物データ大東建託(掲載終了) 登録値確認：経度');
		System.assertEquals(bu_before.IsFirstSurroundingImportFlag__c, bu.IsFirstSurroundingImportFlag__c, '建物データ大東建託(新規) 登録値確認：初回周辺取込フラグ');
		System.assertEquals(bu_before.IsWebCooperationAvailableFlag__c, bu.IsWebCooperationAvailableFlag__c, '建物データ大東建託(新規) 登録値確認：Web連携可能フラグ');
		System.assertEquals(bu_before.BuildingRemarksPrivate__c, bu.BuildingRemarksPrivate__c,  '建物データ大東建託(掲載終了) 登録値確認：建物備考');
		System.assertEquals(bu_before.IsMergeCompletedFlag__c, bu.IsMergeCompletedFlag__c, '建物データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
	}


	// 1:新規 リアプロ
	// 物件データ登録値確認(新規登録)
	@isTest static void checkPropertyNewDataRealnetpro() {
		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
			PropertyDetailUrl__c			= propertyDetailUrl,
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_EXISTS,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		// 2022.06.3 大東建託連携
		// 物件オブジェクトの登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別　2022/6/30 項目追加
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE Name =: propertyName
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データリアプロ(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データリアプロ(新規) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データリアプロ(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE, pr.MaintenancePropertyCode__c, '物件データリアプロ(新規) 登録値確認：メンテナンス物件コード');
		System.assertEquals(propertyName, pr.Name, '物件データリアプロ(新規) 登録値確認：部屋番号');
		System.assertEquals(floor, pr.Floor__c, '物件データリアプロ(新規) 登録値確認：所在階');
		System.assertEquals(balconyDirection, pr.BalconyDirection__c, '物件データリアプロ(新規) 登録値確認：バルコニー方向');
		System.assertEquals(roomArea, pr.RoomArea__c, '物件データリアプロ(新規) 登録値確認：専有面積');
		System.assertEquals(balconyArea, pr.BalconyArea__c, '物件データリアプロ(新規) 登録値確認：バルコニー面積');
		System.assertEquals(roomCount, pr.RoomCount__c, '物件データリアプロ(新規) 登録値確認：部屋数');
		System.assertEquals(roomLayout, pr.RoomLayout__c, '物件データリアプロ(新規) 登録値確認：間取り');
		System.assertEquals(CommonConst.PROPERTY_TRANSACTIONASPECT_GENERALBROKERAGE, pr.TransactionAspect__c, '物件データリアプロ(新規) 登録値確認：取引態様');
		System.assertEquals(deliveryType, pr.DeliveryType__c, '物件データリアプロ(新規) 登録値確認：引渡種別');
		System.assertEquals(deliveryYear, pr.DeliveryYear__c, '物件データリアプロ(新規) 登録値確認：引渡 年');
		System.assertEquals(deliveryMonth, pr.DeliveryMonth__c, '物件データリアプロ(新規) 登録値確認：引渡 月');
		System.assertEquals(deliveryDay, pr.DeliveryDay__c, '物件データリアプロ(新規) 登録値確認：引渡 日');
		System.assertEquals(deliveryTiming, pr.DeliveryTiming__c, '物件データリアプロ(新規) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データリアプロ(新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データリアプロ(新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データリアプロ(新規) 登録値確認：火災保険タイトル');
		System.assertEquals(guaranteeidCompanyType, pr.GuaranteeidCompanyType__c, '物件データリアプロ(新規) 登録値確認：保証会社(利用区分)');
		System.assertEquals(null, pr.BicycleParkingType__c, '物件データリアプロ(新規) 登録値確認：駐輪場種別');
		System.assertEquals(null, pr.BikeStorageType__c, '物件データリアプロ(新規) 登録値確認：バイク置場種別');
		System.assertEquals(null, pr.DeliveryConsultation__c, '物件データリアプロ(新規) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(null, pr.LivedType__c, '物件データリアプロ(新規) 登録値確認：未入居種別');
		System.assertEquals(null, pr.RenovationComplateYear__c, '物件データリアプロ(新規) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(null, pr.RenovationComplateMonth__c, '物件データリアプロ(新規) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(null, pr.RenovationContent__c, '物件データリアプロ(新規) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データリアプロ(新規) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データリアプロ(新規) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データリアプロ(新規) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データリアプロ(新規) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データリアプロ(新規) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データリアプロ(新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データリアプロ(新規) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データリアプロ(新規) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データリアプロ(新規) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データリアプロ(新規) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データリアプロ(新規) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データリアプロ(新規) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データリアプロ(新規) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データリアプロ(新規) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データリアプロ(新規) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データリアプロ(新規) 登録値確認：敷引・償却(円)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonth__c, '物件データリアプロ(新規) 登録値確認：更新料(ヵ月)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(renewalFeeUnit, pr.RenewalFeeUnit__c, '物件データリアプロ(新規) 登録値確認：更新料単位');
		System.assertEquals(renewalFeeTaxType, pr.RenewalFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：更新料税区分');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYen__c, '物件データリアプロ(新規) 登録値確認：更新料(円)');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(keyExchangeFee, pr.KeyExchangeFee__c, '物件データリアプロ(新規) 登録値確認：鍵交換費');
		System.assertEquals(keyExchangeFeeTaxType, pr.KeyExchangeFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：鍵交換費税区分');
		System.assertEquals(wortFee, pr.WortFee__c, '物件データリアプロ(新規) 登録値確認：水道料金');
		System.assertEquals(wortFeeTaxType, pr.WortFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：水道料金税区分');
		System.assertEquals(townshipFee, pr.TownshipFee__c, '物件データリアプロ(新規) 登録値確認：町内会費');
		System.assertEquals(townshipFeeTaxType, pr.TownshipFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：町内会費税区分');
		System.assertEquals(townshipFeePaymentType, pr.TownshipFeePaymentType__c, '物件データリアプロ(新規) 登録値確認：町内会費支払区分');
		System.assertEquals(CATVFee, pr.CATVFee__c, '物件データリアプロ(新規) 登録値確認：CATV');
		System.assertEquals(CATVTaxType, pr.CATVTaxType__c, '物件データリアプロ(新規) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データリアプロ(新規) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonth__c, '物件データリアプロ(新規) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データリアプロ(新規) 登録値確認：定額修繕費単位');
		System.assertEquals(cleaningFeeTaxType, pr.CleaningFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：定額修繕費税区分');
		System.assertEquals(cleaningFeePaymentType, pr.CleaningFeePaymentType__c, '物件データリアプロ(新規) 登録値確認：定額修繕費支払区分');
		System.assertEquals(null, pr.FreeRentTermMonth__c, '物件データリアプロ(新規) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(null, pr.FreeRentContent__c, '物件データリアプロ(新規) 登録値確認：フリーレント内容');
		System.assertEquals(null, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データリアプロ(新規) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(null, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データリアプロ(新規) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(null, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データリアプロ(新規) 登録値確認：特優賃料金変動区分');
		System.assertEquals(null, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データリアプロ(新規) 登録値確認：特優賃上昇率');
		System.assertEquals(null, pr.SpecificExcellentRentSupportYears__c, '物件データリアプロ(新規) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(null, pr.SpecificExcellentRentRemarks__c, '物件データリアプロ(新規) 登録値確認：特優賃備考');
		System.assertEquals(null, pr.ContractTermYear__c, '物件データリアプロ(新規) 登録値確認：契約期間(年)');
		System.assertEquals(null, pr.ContractTermMonth__c, '物件データリアプロ(新規) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データリアプロ(新規) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データリアプロ(新規) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データリアプロ(新規) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(parkingFee, pr.ParkingFee__c, '物件データリアプロ(新規) 登録値確認：駐車場料金');
		System.assertEquals(parkingFeeTaxType, pr.ParkingFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データリアプロ(新規) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(keyPlace, pr.KeyPlace__c, '物件データリアプロ(新規) 登録値確認：鍵所在');
		System.assertEquals(rewardBurdenLender, pr.RewardBurdenLender__c, '物件データリアプロ(新規) 登録値確認：報酬負担貸主');
		System.assertEquals(rewardBurdenBorrower, pr.RewardBurdenBorrower__c, '物件データリアプロ(新規) 登録値確認：報酬負担借主');
		System.assertEquals(rewardSplitFormerSupplier, pr.RewardSplitFormerSupplier__c, '物件データリアプロ(新規) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データリアプロ(新規) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データリアプロ(新規) 登録値確認：広告料単位');
		System.assertEquals(ADFeeMonth, pr.ADFeeMonth__c, '物件データリアプロ(新規) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データリアプロ(新規) 登録値確認：広告料(%)');
		System.assertEquals(ADFeeTaxType, pr.ADFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データリアプロ(新規) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データリアプロ(新規) 登録値確認：広告備考(非公開)');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.GarbageDisposalFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.TownshipInitialFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：入町費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BicycleParkingFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.ParkingDepositTaxType__c, '物件データリアプロ(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingSmallFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingMediumFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkinLargeFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + parkingFee, pr.RentFeeSearchParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + parkingFee, pr.RentFeeSearchManagementParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(LiveStatus, pr.LiveStatus__c, '物件データリアプロ(新規) 登録値確認：現況');
		System.assertEquals(webPublishing, pr.WebPublishing__c, '物件データリアプロ(新規) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データリアプロ(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データリアプロ(新規) 登録値確認：一括確認日');
		System.assertEquals(null, pr.OwnCompanyManageModDate__c, '物件データリアプロ(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データリアプロ(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データリアプロ(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c != null, '物件データリアプロ(新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データリアプロ(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 1:新規 大東建託
	// 物件データ登録値確認(新規登録)
	@isTest static void checkPropertyNewDataDaitoukentaku() {
		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU;	// 外部サイトコード
		String propertyName = '大東建託メンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_NEW,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_EXISTS,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE Name =: propertyName
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データ大東建託(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データ大東建託(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データ大東建託(新規) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データ大東建託(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE, pr.MaintenancePropertyCode__c, '物件データ大東建託(新規) 登録値確認：メンテナンス物件コード');
		System.assertEquals(propertyName, pr.Name, '物件データ大東建託(新規) 登録値確認：部屋番号');
		System.assertEquals(floor, pr.Floor__c, '物件データ大東建託(新規) 登録値確認：所在階');
		System.assertEquals(balconyDirection, pr.BalconyDirection__c, '物件データ大東建託(新規) 登録値確認：バルコニー方向');
		System.assertEquals(roomArea, pr.RoomArea__c, '物件データ大東建託(新規) 登録値確認：専有面積');
		System.assertEquals(balconyArea, pr.BalconyArea__c, '物件データ大東建託(新規) 登録値確認：バルコニー面積');
		System.assertEquals(roomCount, pr.RoomCount__c, '物件データ大東建託(新規) 登録値確認：部屋数');
		System.assertEquals(roomLayout, pr.RoomLayout__c, '物件データ大東建託(新規) 登録値確認：間取り');
		System.assertEquals(CommonConst.PROPERTY_TRANSACTIONASPECT_GENERALBROKERAGE, pr.TransactionAspect__c, '物件データ大東建託(新規) 登録値確認：取引態様');
		System.assertEquals(deliveryType, pr.DeliveryType__c, '物件データ大東建託(新規) 登録値確認：引渡種別');
		System.assertEquals(deliveryYear, pr.DeliveryYear__c, '物件データ大東建託(新規) 登録値確認：引渡 年');
		System.assertEquals(deliveryMonth, pr.DeliveryMonth__c, '物件データ大東建託(新規) 登録値確認：引渡 月');
		System.assertEquals(null, pr.DeliveryDay__c, '物件データ大東建託(新規) 登録値確認：引渡 日');
		System.assertEquals(deliveryTiming, pr.DeliveryTiming__c, '物件データ大東建託(新規) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データ大東建託(新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データ大東建託(新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データ大東建託(新規) 登録値確認：火災保険タイトル');
		System.assertEquals(guaranteeidCompanyType, pr.GuaranteeidCompanyType__c, '物件データ大東建託(新規) 登録値確認：保証会社(利用区分)');
		System.assertEquals(AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, pr.BicycleParkingType__c, '物件データリアプロ(新規) 登録値確認：駐輪場種別');
		System.assertEquals(AUTOMAINTEDIFF_BIKEYARD_EXISTS, pr.BikeStorageType__c, '物件データリアプロ(新規) 登録値確認：バイク置場種別');
		System.assertEquals(deliveryConsultation, pr.DeliveryConsultation__c, '物件データ大東建託(新規) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(AUTOMAINTEDIFF_MOVEIN_EXISTS, pr.LivedType__c, '物件データ大東建託(新規) 登録値確認：未入居種別');
		System.assertEquals(renovationComplateYear, pr.RenovationComplateYear__c, '物件データ大東建託(新規) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(renovationComplateMonth, pr.RenovationComplateMonth__c, '物件データ大東建託(新規) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(renovationContent, pr.RenovationContent__c, '物件データ大東建託(新規) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データ大東建託(新規) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データ大東建託(新規) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データ大東建託(新規) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データ大東建託(新規) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データ大東建託(新規) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データ大東建託(新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データ大東建託(新規) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データ大東建託(新規) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データ大東建託(新規) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データ大東建託(新規) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データ大東建託(新規) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データ大東建託(新規) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データ大東建託(新規) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データ大東建託(新規) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データ大東建託(新規) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データ大東建託(新規) 登録値確認：敷引・償却(円)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonth__c, '物件データ大東建託(新規) 登録値確認：更新料(ヵ月)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(renewalFeeUnit, pr.RenewalFeeUnit__c, '物件データ大東建託(新規) 登録値確認：更新料単位');
		System.assertEquals(null, pr.RenewalFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：更新料税区分');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYen__c, '物件データ大東建託(新規) 登録値確認：更新料(円)');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(keyExchangeFee, pr.KeyExchangeFee__c, '物件データ大東建託(新規) 登録値確認：鍵交換費');
		System.assertEquals(null, pr.KeyExchangeFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：鍵交換費税区分');
		System.assertEquals(null, pr.WortFee__c, '物件データ大東建託(新規) 登録値確認：水道料金');
		System.assertEquals(null, pr.WortFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：水道料金税区分');
		System.assertEquals(townshipFee, pr.TownshipFee__c, '物件データ大東建託(新規) 登録値確認：町内会費');
		System.assertEquals(null, pr.TownshipFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：町内会費税区分');
		System.assertEquals(null, pr.TownshipFeePaymentType__c, '物件データ大東建託(新規) 登録値確認：町内会費支払区分');
		System.assertEquals(CATVFee, pr.CATVFee__c, '物件データ大東建託(新規) 登録値確認：CATV');
		System.assertEquals(null, pr.CATVTaxType__c, '物件データ大東建託(新規) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データ大東建託(新規) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(null, pr.CleaningFeeMonth__c, '物件データ大東建託(新規) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データ大東建託(新規) 登録値確認：定額修繕費単位');
		System.assertEquals(null, pr.CleaningFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：定額修繕費税区分');
		System.assertEquals(null, pr.CleaningFeePaymentType__c, '物件データ大東建託(新規) 登録値確認：定額修繕費支払区分');
		System.assertEquals(freeRentTermMonth, pr.FreeRentTermMonth__c, '物件データ大東建託(新規) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(freeRentContent, pr.FreeRentContent__c, '物件データ大東建託(新規) 登録値確認：フリーレント内容');
		System.assertEquals(specificExcellentRentBurdenUpperLimit, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データ大東建託(新規) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(specificExcellentRentBurdenLowerLimit, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データ大東建託(新規) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データ大東建託(新規) 登録値確認：特優賃料金変動区分');
		System.assertEquals(specificExcellentRentFeeUpwardRate, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データ大東建託(新規) 登録値確認：特優賃上昇率');
		System.assertEquals(specificExcellentRentSupportYears, pr.SpecificExcellentRentSupportYears__c, '物件データ大東建託(新規) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(specificExcellentRentRemarks, pr.SpecificExcellentRentRemarks__c, '物件データ大東建託(新規) 登録値確認：特優賃備考');
		System.assertEquals(contractTermYear, pr.ContractTermYear__c, '物件データ大東建託(新規) 登録値確認：契約期間(年)');
		System.assertEquals(contractTermMonth, pr.ContractTermMonth__c, '物件データ大東建託(新規) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データ大東建託(新規) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データ大東建託(新規) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データ大東建託(新規) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(parkingFee, pr.ParkingFee__c, '物件データ大東建託(新規) 登録値確認：駐車場料金');
		System.assertEquals(parkingFeeTaxType, pr.ParkingFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データ大東建託(新規) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(keyPlace, pr.KeyPlace__c, '物件データ大東建託(新規) 登録値確認：鍵所在');
		System.assertEquals(null, pr.RewardBurdenLender__c, '物件データ大東建託(新規) 登録値確認：報酬負担貸主');
		System.assertEquals(rewardBurdenBorrower, pr.RewardBurdenBorrower__c, '物件データ大東建託(新規) 登録値確認：報酬負担借主');
		System.assertEquals(null, pr.RewardSplitFormerSupplier__c, '物件データ大東建託(新規) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データ大東建託(新規) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データ大東建託(新規) 登録値確認：広告料単位');
		System.assertEquals(null, pr.ADFeeMonth__c, '物件データ大東建託(新規) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データ大東建託(新規) 登録値確認：広告料(%)');
		System.assertEquals(null, pr.ADFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データ大東建託(新規) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データ大東建託(新規) 登録値確認：広告備考(非公開)');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.GarbageDisposalFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.TownshipInitialFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：入町費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BicycleParkingFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.ParkingDepositTaxType__c, '物件データ大東建託(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingSmallFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingMediumFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkinLargeFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + parkingFee, pr.RentFeeSearchParking__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + parkingFee, pr.RentFeeSearchManagementParking__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(LiveStatus, pr.LiveStatus__c, '物件データ大東建託(新規) 登録値確認：現況');
		System.assertEquals('しない', pr.WebPublishing__c, '物件データ大東建託(新規) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データ大東建託(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データ大東建託(新規) 登録値確認：一括確認日');
		System.assertEquals(null, pr.OwnCompanyManageModDate__c, '物件データ大東建託(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データ大東建託(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データ大東建託(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c != null, '物件データ大東建託(新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データ大東建託(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 2:物件新規 リアプロ
	// 物件データ登録値確認(新規登録)
	@isTest static void checkPropertyNewPropertyRealnetpro() {
		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_EXISTS,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE Name =: propertyName
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データリアプロ(物件新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データリアプロ(物件新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データリアプロ(物件新規) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データリアプロ(物件新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE, pr.MaintenancePropertyCode__c, '物件データリアプロ(物件新規) 登録値確認：メンテナンス物件コード');
		System.assertEquals(propertyName, pr.Name, '物件データリアプロ(物件新規) 登録値確認：部屋番号');
		System.assertEquals(floor, pr.Floor__c, '物件データリアプロ(物件新規) 登録値確認：所在階');
		System.assertEquals(balconyDirection, pr.BalconyDirection__c, '物件データリアプロ(物件新規) 登録値確認：バルコニー方向');
		System.assertEquals(roomArea, pr.RoomArea__c, '物件データリアプロ(物件新規) 登録値確認：専有面積');
		System.assertEquals(balconyArea, pr.BalconyArea__c, '物件データリアプロ(物件新規) 登録値確認：バルコニー面積');
		System.assertEquals(roomCount, pr.RoomCount__c, '物件データリアプロ(物件新規) 登録値確認：部屋数');
		System.assertEquals(roomLayout, pr.RoomLayout__c, '物件データリアプロ(物件新規) 登録値確認：間取り');
		System.assertEquals(CommonConst.PROPERTY_TRANSACTIONASPECT_GENERALBROKERAGE, pr.TransactionAspect__c, '物件データリアプロ(物件新規) 登録値確認：取引態様');
		System.assertEquals(deliveryType, pr.DeliveryType__c, '物件データリアプロ(物件新規) 登録値確認：引渡種別');
		System.assertEquals(deliveryYear, pr.DeliveryYear__c, '物件データリアプロ(物件新規) 登録値確認：引渡 年');
		System.assertEquals(deliveryMonth, pr.DeliveryMonth__c, '物件データリアプロ(物件新規) 登録値確認：引渡 月');
		System.assertEquals(deliveryDay, pr.DeliveryDay__c, '物件データリアプロ(物件新規) 登録値確認：引渡 日');
		System.assertEquals(deliveryTiming, pr.DeliveryTiming__c, '物件データリアプロ(物件新規) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データリアプロ(物件新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データリアプロ(物件新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データリアプロ(物件新規) 登録値確認：火災保険タイトル');
		System.assertEquals(guaranteeidCompanyType, pr.GuaranteeidCompanyType__c, '物件データリアプロ(物件新規) 登録値確認：保証会社(利用区分)');
		System.assertEquals(null, pr.BicycleParkingType__c, '物件データリアプロ(新規) 登録値確認：駐輪場種別');
		System.assertEquals(null, pr.BikeStorageType__c, '物件データリアプロ(新規) 登録値確認：バイク置場種別');
		System.assertEquals(null, pr.DeliveryConsultation__c, '物件データリアプロ(物件新規) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(null, pr.LivedType__c, '物件データリアプロ(物件新規) 登録値確認：未入居種別');
		System.assertEquals(null, pr.RenovationComplateYear__c, '物件データリアプロ(物件新規) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(null, pr.RenovationComplateMonth__c, '物件データリアプロ(物件新規) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(null, pr.RenovationContent__c, '物件データリアプロ(物件新規) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データリアプロ(物件新規) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データリアプロ(物件新規) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データリアプロ(物件新規) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データリアプロ(物件新規) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データリアプロ(物件新規) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データリアプロ(物件新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データリアプロ(物件新規) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データリアプロ(物件新規) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データリアプロ(物件新規) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データリアプロ(物件新規) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データリアプロ(物件新規) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データリアプロ(物件新規) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データリアプロ(物件新規) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データリアプロ(物件新規) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データリアプロ(物件新規) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データリアプロ(物件新規) 登録値確認：敷引・償却(円)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonth__c, '物件データリアプロ(物件新規) 登録値確認：更新料(ヵ月)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonthSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(renewalFeeUnit, pr.RenewalFeeUnit__c, '物件データリアプロ(物件新規) 登録値確認：更新料単位');
		System.assertEquals(renewalFeeTaxType, pr.RenewalFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：更新料税区分');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYen__c, '物件データリアプロ(物件新規) 登録値確認：更新料(円)');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYenSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(keyExchangeFee, pr.KeyExchangeFee__c, '物件データリアプロ(物件新規) 登録値確認：鍵交換費');
		System.assertEquals(keyExchangeFeeTaxType, pr.KeyExchangeFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：鍵交換費税区分');
		System.assertEquals(wortFee, pr.WortFee__c, '物件データリアプロ(物件新規) 登録値確認：水道料金');
		System.assertEquals(wortFeeTaxType, pr.WortFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：水道料金税区分');
		System.assertEquals(townshipFee, pr.TownshipFee__c, '物件データリアプロ(物件新規) 登録値確認：町内会費');
		System.assertEquals(townshipFeeTaxType, pr.TownshipFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：町内会費税区分');
		System.assertEquals(townshipFeePaymentType, pr.TownshipFeePaymentType__c, '物件データリアプロ(物件新規) 登録値確認：町内会費支払区分');
		System.assertEquals(CATVFee, pr.CATVFee__c, '物件データリアプロ(物件新規) 登録値確認：CATV');
		System.assertEquals(CATVTaxType, pr.CATVTaxType__c, '物件データリアプロ(物件新規) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データリアプロ(物件新規) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonth__c, '物件データリアプロ(物件新規) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データリアプロ(物件新規) 登録値確認：定額修繕費単位');
		System.assertEquals(cleaningFeeTaxType, pr.CleaningFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：定額修繕費税区分');
		System.assertEquals(cleaningFeePaymentType, pr.CleaningFeePaymentType__c, '物件データリアプロ(物件新規) 登録値確認：定額修繕費支払区分');
		System.assertEquals(null, pr.FreeRentTermMonth__c, '物件データリアプロ(物件新規) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(null, pr.FreeRentContent__c, '物件データリアプロ(物件新規) 登録値確認：フリーレント内容');
		System.assertEquals(null, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データリアプロ(物件新規) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(null, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データリアプロ(物件新規) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(null, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データリアプロ(物件新規) 登録値確認：特優賃料金変動区分');
		System.assertEquals(null, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データリアプロ(物件新規) 登録値確認：特優賃上昇率');
		System.assertEquals(null, pr.SpecificExcellentRentSupportYears__c, '物件データリアプロ(物件新規) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(null, pr.SpecificExcellentRentRemarks__c, '物件データリアプロ(物件新規) 登録値確認：特優賃備考');
		System.assertEquals(null, pr.ContractTermYear__c, '物件データリアプロ(物件新規) 登録値確認：契約期間(年)');
		System.assertEquals(null, pr.ContractTermMonth__c, '物件データリアプロ(物件新規) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データリアプロ(物件新規) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データリアプロ(物件新規) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データリアプロ(物件新規) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(parkingFee, pr.ParkingFee__c, '物件データリアプロ(物件新規) 登録値確認：駐車場料金');
		System.assertEquals(parkingFeeTaxType, pr.ParkingFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データリアプロ(物件新規) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(keyPlace, pr.KeyPlace__c, '物件データリアプロ(物件新規) 登録値確認：鍵所在');
		System.assertEquals(rewardBurdenLender, pr.RewardBurdenLender__c, '物件データリアプロ(物件新規) 登録値確認：報酬負担貸主');
		System.assertEquals(rewardBurdenBorrower, pr.RewardBurdenBorrower__c, '物件データリアプロ(物件新規) 登録値確認：報酬負担借主');
		System.assertEquals(rewardSplitFormerSupplier, pr.RewardSplitFormerSupplier__c, '物件データリアプロ(物件新規) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データリアプロ(物件新規) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データリアプロ(物件新規) 登録値確認：広告料単位');
		System.assertEquals(ADFeeMonth, pr.ADFeeMonth__c, '物件データリアプロ(物件新規) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データリアプロ(物件新規) 登録値確認：広告料(%)');
		System.assertEquals(ADFeeTaxType, pr.ADFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データリアプロ(物件新規) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データリアプロ(物件新規) 登録値確認：広告備考(非公開)');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.GarbageDisposalFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.TownshipInitialFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：入町費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BicycleParkingFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.ParkingDepositTaxType__c, '物件データリアプロ(物件新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingSmallFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingMediumFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkinLargeFeeTaxType__c, '物件データリアプロ(物件新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + parkingFee, pr.RentFeeSearchParking__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + parkingFee, pr.RentFeeSearchManagementParking__c, '物件データリアプロ(物件新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(LiveStatus, pr.LiveStatus__c, '物件データリアプロ(物件新規) 登録値確認：現況');
		System.assertEquals(webPublishing, pr.WebPublishing__c, '物件データリアプロ(物件新規) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データリアプロ(物件新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データリアプロ(物件新規) 登録値確認：一括確認日');
		System.assertEquals(null, pr.OwnCompanyManageModDate__c, '物件データリアプロ(物件新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データリアプロ(物件新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データリアプロ(物件新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データリアプロ(物件新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c != null, '物件データリアプロ(物件新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データリアプロ(物件新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 2:物件新規 大東建託
	// 物件データ登録値確認(新規登録)
	@isTest static void checkPropertyNewPropertyDaitoukentaku() {
		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU;	// 外部サイトコード
		String propertyName = '大東建託メンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_PROPERTY_NEW,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_EXISTS,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE Name =: propertyName
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データ大東建託(物件新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データ大東建託(物件新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データ大東建託(物件新規) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データ大東建託(物件新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE, pr.MaintenancePropertyCode__c, '物件データ大東建託(物件新規) 登録値確認：メンテナンス物件コード');
		System.assertEquals(propertyName, pr.Name, '物件データ大東建託(物件新規) 登録値確認：部屋番号');
		System.assertEquals(floor, pr.Floor__c, '物件データ大東建託(物件新規) 登録値確認：所在階');
		System.assertEquals(balconyDirection, pr.BalconyDirection__c, '物件データ大東建託(物件新規) 登録値確認：バルコニー方向');
		System.assertEquals(roomArea, pr.RoomArea__c, '物件データ大東建託(物件新規) 登録値確認：専有面積');
		System.assertEquals(balconyArea, pr.BalconyArea__c, '物件データ大東建託(物件新規) 登録値確認：バルコニー面積');
		System.assertEquals(roomCount, pr.RoomCount__c, '物件データ大東建託(物件新規) 登録値確認：部屋数');
		System.assertEquals(roomLayout, pr.RoomLayout__c, '物件データ大東建託(物件新規) 登録値確認：間取り');
		System.assertEquals(CommonConst.PROPERTY_TRANSACTIONASPECT_GENERALBROKERAGE, pr.TransactionAspect__c, '物件データ大東建託(物件新規) 登録値確認：取引態様');
		System.assertEquals(deliveryType, pr.DeliveryType__c, '物件データ大東建託(物件新規) 登録値確認：引渡種別');
		System.assertEquals(deliveryYear, pr.DeliveryYear__c, '物件データ大東建託(物件新規) 登録値確認：引渡 年');
		System.assertEquals(deliveryMonth, pr.DeliveryMonth__c, '物件データ大東建託(物件新規) 登録値確認：引渡 月');
		System.assertEquals(null, pr.DeliveryDay__c, '物件データ大東建託(物件新規) 登録値確認：引渡 日');
		System.assertEquals(deliveryTiming, pr.DeliveryTiming__c, '物件データ大東建託(物件新規) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データ大東建託(物件新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データ大東建託(物件新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データ大東建託(物件新規) 登録値確認：火災保険タイトル');
		System.assertEquals(guaranteeidCompanyType, pr.GuaranteeidCompanyType__c, '物件データ大東建託(物件新規) 登録値確認：保証会社(利用区分)');
		System.assertEquals(AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, pr.BicycleParkingType__c, '物件データ大東建託(物件新規) 登録値確認：駐輪場種別');
		System.assertEquals(AUTOMAINTEDIFF_BIKEYARD_EXISTS, pr.BikeStorageType__c, '物件データ大東建託(物件新規) 登録値確認：バイク置場種別');
		System.assertEquals(deliveryConsultation, pr.DeliveryConsultation__c, '物件データ大東建託(物件新規) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(AUTOMAINTEDIFF_MOVEIN_EXISTS, pr.LivedType__c, '物件データ大東建託(物件新規) 登録値確認：未入居種別');
		System.assertEquals(renovationComplateYear, pr.RenovationComplateYear__c, '物件データ大東建託(物件新規) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(renovationComplateMonth, pr.RenovationComplateMonth__c, '物件データ大東建託(物件新規) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(renovationContent, pr.RenovationContent__c, '物件データ大東建託(物件新規) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データ大東建託(物件新規) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データ大東建託(物件新規) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データ大東建託(物件新規) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データ大東建託(物件新規) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データ大東建託(物件新規) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データ大東建託(物件新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データ大東建託(物件新規) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データ大東建託(物件新規) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データ大東建託(物件新規) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データ大東建託(物件新規) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データ大東建託(物件新規) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データ大東建託(物件新規) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データ大東建託(物件新規) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データ大東建託(物件新規) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データ大東建託(物件新規) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データ大東建託(物件新規) 登録値確認：敷引・償却(円)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonth__c, '物件データ大東建託(物件新規) 登録値確認：更新料(ヵ月)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonthSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(renewalFeeUnit, pr.RenewalFeeUnit__c, '物件データ大東建託(物件新規) 登録値確認：更新料単位');
		System.assertEquals(null, pr.RenewalFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：更新料税区分');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYen__c, '物件データ大東建託(物件新規) 登録値確認：更新料(円)');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYenSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(keyExchangeFee, pr.KeyExchangeFee__c, '物件データ大東建託(物件新規) 登録値確認：鍵交換費');
		System.assertEquals(null, pr.KeyExchangeFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：鍵交換費税区分');
		System.assertEquals(null, pr.WortFee__c, '物件データ大東建託(物件新規) 登録値確認：水道料金');
		System.assertEquals(null, pr.WortFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：水道料金税区分');
		System.assertEquals(townshipFee, pr.TownshipFee__c, '物件データ大東建託(物件新規) 登録値確認：町内会費');
		System.assertEquals(null, pr.TownshipFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：町内会費税区分');
		System.assertEquals(null, pr.TownshipFeePaymentType__c, '物件データ大東建託(物件新規) 登録値確認：町内会費支払区分');
		System.assertEquals(CATVFee, pr.CATVFee__c, '物件データ大東建託(物件新規) 登録値確認：CATV');
		System.assertEquals(null, pr.CATVTaxType__c, '物件データ大東建託(物件新規) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データ大東建託(物件新規) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(null, pr.CleaningFeeMonth__c, '物件データ大東建託(物件新規) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データ大東建託(物件新規) 登録値確認：定額修繕費単位');
		System.assertEquals(null, pr.CleaningFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：定額修繕費税区分');
		System.assertEquals(null, pr.CleaningFeePaymentType__c, '物件データ大東建託(物件新規) 登録値確認：定額修繕費支払区分');
		System.assertEquals(freeRentTermMonth, pr.FreeRentTermMonth__c, '物件データ大東建託(物件新規) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(freeRentContent, pr.FreeRentContent__c, '物件データ大東建託(物件新規) 登録値確認：フリーレント内容');
		System.assertEquals(specificExcellentRentBurdenUpperLimit, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データ大東建託(物件新規) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(specificExcellentRentBurdenLowerLimit, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データ大東建託(物件新規) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データ大東建託(物件新規) 登録値確認：特優賃料金変動区分');
		System.assertEquals(specificExcellentRentFeeUpwardRate, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データ大東建託(物件新規) 登録値確認：特優賃上昇率');
		System.assertEquals(specificExcellentRentSupportYears, pr.SpecificExcellentRentSupportYears__c, '物件データ大東建託(物件新規) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(specificExcellentRentRemarks, pr.SpecificExcellentRentRemarks__c, '物件データ大東建託(物件新規) 登録値確認：特優賃備考');
		System.assertEquals(contractTermYear, pr.ContractTermYear__c, '物件データ大東建託(物件新規) 登録値確認：契約期間(年)');
		System.assertEquals(contractTermMonth, pr.ContractTermMonth__c, '物件データ大東建託(物件新規) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データ大東建託(物件新規) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データ大東建託(物件新規) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データ大東建託(物件新規) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(parkingFee, pr.ParkingFee__c, '物件データ大東建託(物件新規) 登録値確認：駐車場料金');
		System.assertEquals(parkingFeeTaxType, pr.ParkingFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データ大東建託(物件新規) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(keyPlace, pr.KeyPlace__c, '物件データ大東建託(物件新規) 登録値確認：鍵所在');
		System.assertEquals(null, pr.RewardBurdenLender__c, '物件データ大東建託(物件新規) 登録値確認：報酬負担貸主');
		System.assertEquals(rewardBurdenBorrower, pr.RewardBurdenBorrower__c, '物件データ大東建託(物件新規) 登録値確認：報酬負担借主');
		System.assertEquals(null, pr.RewardSplitFormerSupplier__c, '物件データ大東建託(物件新規) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データ大東建託(物件新規) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データ大東建託(物件新規) 登録値確認：広告料単位');
		System.assertEquals(null, pr.ADFeeMonth__c, '物件データ大東建託(物件新規) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データ大東建託(物件新規) 登録値確認：広告料(%)');
		System.assertEquals(null, pr.ADFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データ大東建託(物件新規) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データ大東建託(物件新規) 登録値確認：広告備考(非公開)');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.GarbageDisposalFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.TownshipInitialFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：入町費税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BicycleParkingFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.ParkingDepositTaxType__c, '物件データ大東建託(物件新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingSmallFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkingMediumFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(CommonConst.PROPERTY_TAXTYPE_NOTAXABLE, pr.BikeParkinLargeFeeTaxType__c, '物件データ大東建託(物件新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + parkingFee, pr.RentFeeSearchParking__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + parkingFee, pr.RentFeeSearchManagementParking__c, '物件データ大東建託(物件新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(LiveStatus, pr.LiveStatus__c, '物件データ大東建託(物件新規) 登録値確認：現況');
		System.assertEquals('しない', pr.WebPublishing__c, '物件データ大東建託(物件新規) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データ大東建託(物件新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データ大東建託(物件新規) 登録値確認：一括確認日');
		System.assertEquals(null, pr.OwnCompanyManageModDate__c, '物件データ大東建託(物件新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データ大東建託(物件新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データ大東建託(物件新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データ大東建託(物件新規) 登録値確認：名寄せ完了フラグ');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データ大東建託(物件新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 3:条件変更 リアプロ
	// 物件データ登録値確認(新規登録)
	@isTest static void checkPropertyChangeConditionsRealnetpro() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceRealnetpro();
		insert pr_AutoMainte;

		//更新前にデータを取得し、保持 
		Property__c pr_before= [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE
			LIMIT 1];

		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_NO,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データリアプロ(条件変更) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データリアプロ(条件変更) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データリアプロ(条件変更) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データリアプロ(条件変更) 登録値確認：物件詳細画面URL');
		System.assertEquals(pr_before.MaintenancePropertyCode__c, pr.MaintenancePropertyCode__c, '物件データリアプロ(条件変更) 登録値確認：メンテナンス物件コード');
		System.assertEquals(pr_before.Name, pr.Name, '物件データリアプロ(条件変更) 登録値確認：部屋番号');
		System.assertEquals(pr_before.Floor__c, pr.Floor__c, '物件データリアプロ(条件変更) 登録値確認：所在階');
		System.assertEquals(pr_before.BalconyDirection__c, pr.BalconyDirection__c, '物件データリアプロ(条件変更) 登録値確認：バルコニー方向');
		System.assertEquals(pr_before.RoomArea__c, pr.RoomArea__c, '物件データリアプロ(条件変更) 登録値確認：専有面積');
		System.assertEquals(pr_before.BalconyArea__c, pr.BalconyArea__c, '物件データリアプロ(条件変更) 登録値確認：バルコニー面積');
		System.assertEquals(pr_before.RoomCount__c, pr.RoomCount__c, '物件データリアプロ(条件変更) 登録値確認：部屋数');
		System.assertEquals(pr_before.RoomLayout__c, pr.RoomLayout__c, '物件データリアプロ(条件変更) 登録値確認：間取り');
		System.assertEquals(pr_before.TransactionAspect__c, pr.TransactionAspect__c, '物件データリアプロ(条件変更) 登録値確認：取引態様');
		System.assertEquals(pr_before.DeliveryType__c, pr.DeliveryType__c, '物件データリアプロ(条件変更) 登録値確認：引渡種別');
		System.assertEquals(pr_before.DeliveryYear__c, pr.DeliveryYear__c, '物件データリアプロ(条件変更) 登録値確認：引渡 年');
		System.assertEquals(pr_before.DeliveryMonth__c, pr.DeliveryMonth__c, '物件データリアプロ(条件変更) 登録値確認：引渡 月');
		System.assertEquals(pr_before.DeliveryDay__c, pr.DeliveryDay__c, '物件データリアプロ(条件変更) 登録値確認：引渡 日');
		System.assertEquals(pr_before.DeliveryTiming__c, pr.DeliveryTiming__c, '物件データリアプロ(条件変更) 登録値確認：引渡 旬');
		System.assertEquals(pr_before.FireInsuranceUseType__c, pr.FireInsuranceUseType__c, '物件データリアプロ(条件変更) 登録値確認：火災保険(加入義務)');
		System.assertEquals(pr_before.FireInsuranceCompany__c, pr.FireInsuranceCompany__c, '物件データリアプロ(条件変更) 登録値確認：火災保険会社');
		System.assertEquals(pr_before.FireInsurancePlan__c, pr.FireInsurancePlan__c, '物件データリアプロ(条件変更) 登録値確認：火災保険タイトル');
		System.assertEquals(pr_before.GuaranteeidCompanyType__c, pr.GuaranteeidCompanyType__c, '物件データリアプロ(条件変更) 登録値確認：保証会社(利用区分)');
		System.assertEquals(pr_before.BicycleParkingType__c, pr.BicycleParkingType__c, '物件データリアプロ(条件変更) 登録値確認：駐輪場種別');
		System.assertEquals(pr_before.BikeStorageType__c, pr.BikeStorageType__c, '物件データリアプロ(条件変更) 登録値確認：バイク置場種別');
		System.assertEquals(pr_before.DeliveryConsultation__c, pr.DeliveryConsultation__c, '物件データリアプロ(条件変更) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(pr_before.LivedType__c, pr.LivedType__c, '物件データリアプロ(条件変更) 登録値確認：未入居種別');
		System.assertEquals(pr_before.RenovationComplateYear__c, pr.RenovationComplateYear__c, '物件データリアプロ(条件変更) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(pr_before.RenovationComplateMonth__c, pr.RenovationComplateMonth__c, '物件データリアプロ(条件変更) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(pr_before.RenovationContent__c, pr.RenovationContent__c, '物件データリアプロ(条件変更) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データリアプロ(条件変更) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データリアプロ(条件変更) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データリアプロ(条件変更) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データリアプロ(条件変更) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データリアプロ(条件変更) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データリアプロ(条件変更) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データリアプロ(条件変更) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データリアプロ(条件変更) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データリアプロ(条件変更) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データリアプロ(条件変更) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データリアプロ(条件変更) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データリアプロ(条件変更) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データリアプロ(条件変更) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データリアプロ(条件変更) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データリアプロ(条件変更) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データリアプロ(条件変更) 登録値確認：敷引・償却(円)');
		System.assertEquals(pr_before.RenewalFeeMonth__c, pr.RenewalFeeMonth__c, '物件データリアプロ(条件変更) 登録値確認：更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeMonthSearch__c, pr.RenewalFeeMonthSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeUnit__c, pr.RenewalFeeUnit__c, '物件データリアプロ(条件変更) 登録値確認：更新料単位');
		System.assertEquals(pr_before.RenewalFeeTaxType__c, pr.RenewalFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：更新料税区分');
		System.assertEquals(pr_before.RenewalFeeYen__c, pr.RenewalFeeYen__c, '物件データリアプロ(条件変更) 登録値確認：更新料(円)');
		System.assertEquals(pr_before.RenewalFeeYenSearch__c, pr.RenewalFeeYenSearch__c, '物件データリアプロ(条件変更) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(pr_before.KeyExchangeFee__c, pr.KeyExchangeFee__c, '物件データリアプロ(条件変更) 登録値確認：鍵交換費');
		System.assertEquals(pr_before.KeyExchangeFeeTaxType__c, pr.KeyExchangeFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：鍵交換費税区分');
		System.assertEquals(pr_before.WortFee__c, pr.WortFee__c, '物件データリアプロ(条件変更) 登録値確認：水道料金');
		System.assertEquals(pr_before.WortFeeTaxType__c, pr.WortFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：水道料金税区分');
		System.assertEquals(pr_before.TownshipFee__c, pr.TownshipFee__c, '物件データリアプロ(条件変更) 登録値確認：町内会費');
		System.assertEquals(pr_before.TownshipFeeTaxType__c, pr.TownshipFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：町内会費税区分');
		System.assertEquals(pr_before.TownshipFeePaymentType__c, pr.TownshipFeePaymentType__c, '物件データリアプロ(条件変更) 登録値確認：町内会費支払区分');
		System.assertEquals(pr_before.CATVFee__c, pr.CATVFee__c, '物件データリアプロ(条件変更) 登録値確認：CATV');
		System.assertEquals(pr_before.CATVTaxType__c, pr.CATVTaxType__c, '物件データリアプロ(条件変更) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データリアプロ(条件変更) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonth__c, '物件データリアプロ(条件変更) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データリアプロ(条件変更) 登録値確認：定額修繕費単位');
		System.assertEquals(cleaningFeeTaxType, pr.CleaningFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：定額修繕費税区分');
		System.assertEquals(cleaningFeePaymentType, pr.CleaningFeePaymentType__c, '物件データリアプロ(条件変更) 登録値確認：定額修繕費支払区分');
		System.assertEquals(pr_before.FreeRentTermMonth__c, pr.FreeRentTermMonth__c, '物件データリアプロ(条件変更) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(pr_before.FreeRentContent__c, pr.FreeRentContent__c, '物件データリアプロ(条件変更) 登録値確認：フリーレント内容');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenUpperLimit__c, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データリアプロ(条件変更) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenLowerLimit__c, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データリアプロ(条件変更) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(pr_before.SpecificExcellentRentFeeFluctuationType__c, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データリアプロ(新規) 登録値確認：特優賃料金変動区分');
		System.assertEquals(pr_before.SpecificExcellentRentFeeUpwardRate__c, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データリアプロ(条件変更) 登録値確認：特優賃上昇率');
		System.assertEquals(pr_before.SpecificExcellentRentSupportYears__c, pr.SpecificExcellentRentSupportYears__c, '物件データリアプロ(条件変更) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(pr_before.SpecificExcellentRentRemarks__c, pr.SpecificExcellentRentRemarks__c, '物件データリアプロ(条件変更) 登録値確認：特優賃備考');
		System.assertEquals(pr_before.ContractTermYear__c, pr.ContractTermYear__c, '物件データリアプロ(条件変更) 登録値確認：契約期間(年)');
		System.assertEquals(pr_before.ContractTermMonth__c, pr.ContractTermMonth__c, '物件データリアプロ(条件変更) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データリアプロ(条件変更) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データリアプロ(条件変更) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データリアプロ(条件変更) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(pr_before.ParkingFee__c, pr.ParkingFee__c, '物件データリアプロ(条件変更) 登録値確認：駐車場料金');
		System.assertEquals(pr_before.ParkingFeeTaxType__c, pr.ParkingFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データリアプロ(条件変更) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(pr_before.KeyPlace__c, pr.KeyPlace__c, '物件データリアプロ(条件変更) 登録値確認：鍵所在');
		System.assertEquals(rewardBurdenLender, pr.RewardBurdenLender__c, '物件データリアプロ(条件変更) 登録値確認：報酬負担貸主');
		System.assertEquals(pr_before.RewardBurdenBorrower__c, pr.RewardBurdenBorrower__c, '物件データリアプロ(条件変更) 登録値確認：報酬負担借主');
		System.assertEquals(rewardSplitFormerSupplier, pr.RewardSplitFormerSupplier__c, '物件データリアプロ(条件変更) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データリアプロ(条件変更) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データリアプロ(条件変更) 登録値確認：広告料単位');
		System.assertEquals(ADFeeMonth, pr.ADFeeMonth__c, '物件データリアプロ(条件変更) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データリアプロ(条件変更) 登録値確認：広告料(%)');
		System.assertEquals(ADFeeTaxType, pr.ADFeeTaxType__c, '物件データリアプロ(条件変更) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データリアプロ(条件変更) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データリアプロ(条件変更) 登録値確認：広告備考(非公開)');
		System.assertEquals(null, pr.GarbageDisposalFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(null, pr.TownshipInitialFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：入町費税区分');
		System.assertEquals(null, pr.BicycleParkingFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(null, pr.ParkingDepositTaxType__c, '物件データリアプロ(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(null, pr.BikeParkingSmallFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkingMediumFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkinLargeFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + pr_before.ParkingFee__c, pr.RentFeeSearchParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + pr_before.ParkingFee__c, pr.RentFeeSearchManagementParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(pr_before.LiveStatus__c, pr.LiveStatus__c, '物件データリアプロ(条件変更) 登録値確認：現況');
		System.assertEquals(pr_before.WebPublishing__c, pr.WebPublishing__c, '物件データリアプロ(条件変更) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データリアプロ(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データリアプロ(新規) 登録値確認：一括確認日');
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.OwnCompanyManageModDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データリアプロ(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データリアプロ(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データリアプロ(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 3:条件変更 大東建託
	// 物件データ登録値確認(新規登録)
	@isTest static void checkPropertyChangeConditionsDaitoukentaku() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceDaitoukentaku();
		insert pr_AutoMainte;

		//更新前にデータを取得し、保持 
		Property__c pr_before= [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE
			LIMIT 1];

		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;	// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_CHANGE_CONDITION,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_NO,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			BatchStatus__c					= CommonConst.AUTOMAINTEDIFF_BATCHSTATUS_1,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データ大東建託(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データ大東建託(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(pr_before.Id, pr.Id, '物件データ大東建託(条件変更) 登録値確認：ID');
		System.assertEquals(importType, pr.ImportType__c, '物件データ大東建託(条件変更) 登録値確認：取込先');
		System.assertEquals(null, pr.PropertyDetailUrl__c, '物件データ大東建託(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(pr_before.MaintenancePropertyCode__c, pr.MaintenancePropertyCode__c, '物件データ大東建託(条件変更) 登録値確認：メンテナンス物件コード');
		System.assertEquals(pr_before.Name, pr.Name, '物件データ大東建託(条件変更) 登録値確認：部屋番号');
		System.assertEquals(pr_before.Floor__c, pr.Floor__c, '物件データ大東建託(条件変更) 登録値確認：所在階');
		System.assertEquals(pr_before.BalconyDirection__c, pr.BalconyDirection__c, '物件データ大東建託(条件変更) 登録値確認：バルコニー方向');
		System.assertEquals(pr_before.RoomArea__c, pr.RoomArea__c, '物件データ大東建託(条件変更) 登録値確認：専有面積');
		System.assertEquals(pr_before.BalconyArea__c, pr.BalconyArea__c, '物件データ大東建託(条件変更) 登録値確認：バルコニー面積');
		System.assertEquals(pr_before.RoomCount__c, pr.RoomCount__c, '物件データ大東建託(条件変更) 登録値確認：部屋数');
		System.assertEquals(pr_before.RoomLayout__c, pr.RoomLayout__c, '物件データ大東建託(条件変更) 登録値確認：間取り');
		System.assertEquals(null, pr.TransactionAspect__c, '物件データ大東建託(新規) 登録値確認：取引態様');
		System.assertEquals(pr_before.DeliveryType__c, pr.DeliveryType__c, '物件データ大東建託(条件変更) 登録値確認：引渡種別');
		System.assertEquals(pr_before.DeliveryYear__c, pr.DeliveryYear__c, '物件データ大東建託(条件変更) 登録値確認：引渡 年');
		System.assertEquals(pr_before.DeliveryMonth__c, pr.DeliveryMonth__c, '物件データ大東建託(条件変更) 登録値確認：引渡 月');
		System.assertEquals(pr_before.DeliveryDay__c, pr.DeliveryDay__c, '物件データ大東建託(条件変更) 登録値確認：引渡 日');
		System.assertEquals(pr_before.DeliveryTiming__c, pr.DeliveryTiming__c, '物件データ大東建託(条件変更) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データ大東建託(新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データ大東建託(新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データ大東建託(新規) 登録値確認：火災保険タイトル');
		System.assertEquals(pr_before.GuaranteeidCompanyType__c, pr.GuaranteeidCompanyType__c, '物件データ大東建託(条件変更) 登録値確認：保証会社(利用区分)');
		System.assertEquals(pr_before.BicycleParkingType__c, pr.BicycleParkingType__c, '物件データ大東建託(条件変更) 登録値確認：駐輪場種別');
		System.assertEquals(pr_before.BikeStorageType__c, pr.BikeStorageType__c, '物件データ大東建託(条件変更) 登録値確認：バイク置場種別');
		System.assertEquals(pr_before.DeliveryConsultation__c, pr.DeliveryConsultation__c, '物件データ大東建託(条件変更) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(pr_before.LivedType__c, pr.LivedType__c, '物件データ大東建託(条件変更) 登録値確認：未入居種別');
		System.assertEquals(pr_before.RenovationComplateYear__c, pr.RenovationComplateYear__c, '物件データ大東建託(条件変更) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(pr_before.RenovationComplateMonth__c, pr.RenovationComplateMonth__c, '物件データ大東建託(条件変更) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(pr_before.RenovationContent__c, pr.RenovationContent__c, '物件データ大東建託(条件変更) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データ大東建託(条件変更) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データ大東建託(条件変更) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データ大東建託(条件変更) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データ大東建託(条件変更) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データ大東建託(条件変更) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データ大東建託(新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データ大東建託(条件変更) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データ大東建託(条件変更) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データ大東建託(条件変更) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データ大東建託(条件変更) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データ大東建託(条件変更) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データ大東建託(条件変更) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データ大東建託(条件変更) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データ大東建託(条件変更) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データ大東建託(条件変更) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データ大東建託(条件変更) 登録値確認：敷引・償却(円)');
		System.assertEquals(pr_before.RenewalFeeMonth__c, pr.RenewalFeeMonth__c, '物件データ大東建託(条件変更) 登録値確認：更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeMonth__c, pr.RenewalFeeMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeUnit__c, pr.RenewalFeeUnit__c, '物件データ大東建託(条件変更) 登録値確認：更新料単位');
		System.assertEquals(pr_before.RenewalFeeTaxType__c, pr.RenewalFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：更新料税区分');
		System.assertEquals(pr_before.RenewalFeeYen__c, pr.RenewalFeeYen__c, '物件データ大東建託(条件変更) 登録値確認：更新料(円)');
		System.assertEquals(pr_before.RenewalFeeYenSearch__c, pr.RenewalFeeYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(pr_before.KeyExchangeFee__c, pr.KeyExchangeFee__c, '物件データ大東建託(条件変更) 登録値確認：鍵交換費');
		System.assertEquals(pr_before.KeyExchangeFeeTaxType__c, pr.KeyExchangeFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：鍵交換費税区分');
		System.assertEquals(pr_before.WortFee__c, pr.WortFee__c, '物件データ大東建託(条件変更) 登録値確認：水道料金');
		System.assertEquals(pr_before.WortFeeTaxType__c, pr.WortFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：水道料金税区分');
		System.assertEquals(pr_before.TownshipFee__c, pr.TownshipFee__c, '物件データ大東建託(条件変更) 登録値確認：町内会費');
		System.assertEquals(pr_before.TownshipFeeTaxType__c, pr.TownshipFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：町内会費税区分');
		System.assertEquals(pr_before.TownshipFeePaymentType__c, pr.TownshipFeePaymentType__c, '物件データ大東建託(条件変更) 登録値確認：町内会費支払区分');
		System.assertEquals(pr_before.CATVFee__c, pr.CATVFee__c, '物件データ大東建託(条件変更) 登録値確認：CATV');
		System.assertEquals(pr_before.CATVTaxType__c, pr.CATVTaxType__c, '物件データ大東建託(条件変更) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データ大東建託(条件変更) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonth__c, '物件データ大東建託(条件変更) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データ大東建託(条件変更) 登録値確認：定額修繕費単位');
		System.assertEquals(pr_before.CleaningFeeTaxType__c, pr.CleaningFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：定額修繕費税区分');
		System.assertEquals(pr_before.CleaningFeePaymentType__c, pr.CleaningFeePaymentType__c, '物件データ大東建託(条件変更) 登録値確認：定額修繕費支払区分');
		System.assertEquals(freeRentTermMonth, pr.FreeRentTermMonth__c, '物件データ大東建託(条件変更) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(freeRentContent, pr.FreeRentContent__c, '物件データ大東建託(条件変更) 登録値確認：フリーレント内容');
		System.assertEquals(specificExcellentRentBurdenUpperLimit, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データ大東建託(条件変更) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(specificExcellentRentBurdenLowerLimit, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データ大東建託(条件変更) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データ大東建託(新規) 登録値確認：特優賃料金変動区分');
		System.assertEquals(specificExcellentRentFeeUpwardRate, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データ大東建託(条件変更) 登録値確認：特優賃上昇率');
		System.assertEquals(specificExcellentRentSupportYears, pr.SpecificExcellentRentSupportYears__c, '物件データ大東建託(条件変更) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(specificExcellentRentRemarks, pr.SpecificExcellentRentRemarks__c, '物件データ大東建託(条件変更) 登録値確認：特優賃備考');
		System.assertEquals(contractTermYear, pr.ContractTermYear__c, '物件データ大東建託(条件変更) 登録値確認：契約期間(年)');
		System.assertEquals(contractTermMonth, pr.ContractTermMonth__c, '物件データ大東建託(条件変更) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データ大東建託(条件変更) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データ大東建託(条件変更) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データ大東建託(条件変更) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(pr_before.ParkingFee__c, pr.ParkingFee__c, '物件データ大東建託(条件変更) 登録値確認：駐車場料金');
		System.assertEquals(pr_before.ParkingFeeTaxType__c, pr.ParkingFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データ大東建託(条件変更) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(pr_before.KeyPlace__c, pr.KeyPlace__c, '物件データ大東建託(条件変更) 登録値確認：鍵所在');
		System.assertEquals(pr_before.RewardBurdenLender__c, pr.RewardBurdenLender__c, '物件データ大東建託(条件変更) 登録値確認：報酬負担貸主');
		System.assertEquals(pr_before.RewardBurdenBorrower__c, pr.RewardBurdenBorrower__c, '物件データ大東建託(条件変更) 登録値確認：報酬負担借主');
		System.assertEquals(pr_before.RewardSplitFormerSupplier__c, pr.RewardSplitFormerSupplier__c, '物件データ大東建託(条件変更) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データ大東建託(条件変更) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データ大東建託(条件変更) 登録値確認：広告料単位');
		System.assertEquals(pr_before.ADFeeMonth__c, pr.ADFeeMonth__c, '物件データ大東建託(条件変更) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データ大東建託(条件変更) 登録値確認：広告料(%)');
		System.assertEquals(pr_before.ADFeeTaxType__c, pr.ADFeeTaxType__c, '物件データ大東建託(条件変更) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データ大東建託(条件変更) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データ大東建託(条件変更) 登録値確認：広告備考(非公開)');
		System.assertEquals(null, pr.GarbageDisposalFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(null, pr.TownshipInitialFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：入町費税区分');
		System.assertEquals(null, pr.BicycleParkingFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(null, pr.ParkingDepositTaxType__c, '物件データ大東建託(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(null, pr.BikeParkingSmallFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkingMediumFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkinLargeFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + pr_before.ParkingFee__c, pr.RentFeeSearchParking__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + pr_before.ParkingFee__c, pr.RentFeeSearchManagementParking__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(pr_before.LiveStatus__c, pr.LiveStatus__c, '物件データ大東建託(条件変更) 登録値確認：現況');
		System.assertEquals(pr_before.WebPublishing__c, pr.WebPublishing__c, '物件データ大東建託(条件変更) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データ大東建託(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データ大東建託(新規) 登録値確認：一括確認日');
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.OwnCompanyManageModDate__c.format('yyyy-MM-dd'), '物件データ大東建託(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データ大東建託(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データ大東建託(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データ大東建託(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 4:新規 居住中→空室 リアプロ
	// 物件データ登録値確認(居住中→空室)
	@isTest static void checkPropertyLivingChangeVacancyRealnetpro() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceRealnetpro();
		insert pr_AutoMainte;

		//更新前にデータを取得し、保持 
		Property__c pr_before= [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE_EXISTS
			LIMIT 1];

		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_NO,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データリアプロ(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データリアプロ(居住中→空室) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データリアプロ(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE_EXISTS, pr.MaintenancePropertyCode__c, '物件データリアプロ(居住中→空室) 登録値確認：メンテナンス物件コード');
		System.assertEquals(pr_before.Name, pr.Name, '物件データリアプロ(居住中→空室) 登録値確認：部屋番号');
		System.assertEquals(pr_before.Floor__c, pr.Floor__c, '物件データリアプロ(居住中→空室) 登録値確認：所在階');
		System.assertEquals(pr_before.BalconyDirection__c, pr.BalconyDirection__c, '物件データリアプロ(居住中→空室) 登録値確認：バルコニー方向');
		System.assertEquals(pr_before.RoomArea__c, pr.RoomArea__c, '物件データリアプロ(居住中→空室) 登録値確認：専有面積');
		System.assertEquals(pr_before.BalconyArea__c, pr.BalconyArea__c, '物件データリアプロ(居住中→空室) 登録値確認：バルコニー面積');
		System.assertEquals(pr_before.RoomCount__c, pr.RoomCount__c, '物件データリアプロ(居住中→空室) 登録値確認：部屋数');
		System.assertEquals(pr_before.RoomLayout__c, pr.RoomLayout__c, '物件データリアプロ(居住中→空室) 登録値確認：間取り');
		System.assertEquals(null, pr.TransactionAspect__c, '物件データリアプロ(新規) 登録値確認：取引態様');
		System.assertEquals(pr_before.DeliveryType__c, pr.DeliveryType__c, '物件データリアプロ(居住中→空室) 登録値確認：引渡種別');
		System.assertEquals(pr_before.DeliveryYear__c, pr.DeliveryYear__c, '物件データリアプロ(居住中→空室) 登録値確認：引渡 年');
		System.assertEquals(pr_before.DeliveryMonth__c, pr.DeliveryMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：引渡 月');
		System.assertEquals(pr_before.DeliveryDay__c, pr.DeliveryDay__c, '物件データリアプロ(居住中→空室) 登録値確認：引渡 日');
		System.assertEquals(pr_before.DeliveryTiming__c, pr.DeliveryTiming__c, '物件データリアプロ(居住中→空室) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データリアプロ(居住中→空室) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データリアプロ(居住中→空室) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データリアプロ(居住中→空室) 登録値確認：火災保険タイトル');
		System.assertEquals(pr_before.GuaranteeidCompanyType__c, pr.GuaranteeidCompanyType__c, '物件データリアプロ(居住中→空室) 登録値確認：保証会社(利用区分)');
		System.assertEquals(pr_before.BicycleParkingType__c, pr.BicycleParkingType__c, '物件データ大東建託(居住中→空室) 登録値確認：駐輪場種別');
		System.assertEquals(pr_before.BikeStorageType__c, pr.BikeStorageType__c, '物件データ大東建託(居住中→空室) 登録値確認：バイク置場種別');
		System.assertEquals(pr_before.DeliveryConsultation__c, pr.DeliveryConsultation__c, '物件データリアプロ(居住中→空室) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(pr_before.LivedType__c, pr.LivedType__c, '物件データリアプロ(居住中→空室) 登録値確認：未入居種別');
		System.assertEquals(pr_before.RenovationComplateYear__c, pr.RenovationComplateYear__c, '物件データリアプロ(居住中→空室) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(pr_before.RenovationComplateMonth__c, pr.RenovationComplateMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(pr_before.RenovationContent__c, pr.RenovationContent__c, '物件データリアプロ(居住中→空室) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データリアプロ(居住中→空室) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データリアプロ(居住中→空室) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データリアプロ(居住中→空室) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データリアプロ(新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データリアプロ(居住中→空室) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データリアプロ(居住中→空室) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データリアプロ(居住中→空室) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データリアプロ(居住中→空室) 登録値確認：敷引・償却(円)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：更新料(ヵ月)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(renewalFeeUnit, pr.RenewalFeeUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：更新料単位');
		System.assertEquals(renewalFeeTaxType, pr.RenewalFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：更新料税区分');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYen__c, '物件データリアプロ(居住中→空室) 登録値確認：更新料(円)');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(keyExchangeFee, pr.KeyExchangeFee__c, '物件データリアプロ(居住中→空室) 登録値確認：鍵交換費');
		System.assertEquals(keyExchangeFeeTaxType, pr.KeyExchangeFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：鍵交換費税区分');
		System.assertEquals(wortFee, pr.WortFee__c, '物件データリアプロ(居住中→空室) 登録値確認：水道料金');
		System.assertEquals(wortFeeTaxType, pr.WortFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：水道料金税区分');
		System.assertEquals(townshipFee, pr.TownshipFee__c, '物件データリアプロ(居住中→空室) 登録値確認：町内会費');
		System.assertEquals(townshipFeeTaxType, pr.TownshipFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：町内会費税区分');
		System.assertEquals(townshipFeePaymentType, pr.TownshipFeePaymentType__c, '物件データリアプロ(居住中→空室) 登録値確認：町内会費支払区分');
		System.assertEquals(CATVFee, pr.CATVFee__c, '物件データリアプロ(居住中→空室) 登録値確認：CATV');
		System.assertEquals(CATVTaxType, pr.CATVTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データリアプロ(居住中→空室) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：定額修繕費単位');
		System.assertEquals(cleaningFeeTaxType, pr.CleaningFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：定額修繕費税区分');
		System.assertEquals(cleaningFeePaymentType, pr.CleaningFeePaymentType__c, '物件データリアプロ(居住中→空室) 登録値確認：定額修繕費支払区分');
		System.assertEquals(pr_before.FreeRentTermMonth__c, pr.FreeRentTermMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(pr_before.FreeRentContent__c, pr.FreeRentContent__c, '物件データリアプロ(居住中→空室) 登録値確認：フリーレント内容');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenUpperLimit__c, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データリアプロ(居住中→空室) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenLowerLimit__c, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データリアプロ(居住中→空室) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(pr_before.SpecificExcellentRentFeeFluctuationType__c, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データリアプロ(居住中→空室) 登録値確認：特優賃料金変動区分');
		System.assertEquals(pr_before.SpecificExcellentRentFeeUpwardRate__c, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データリアプロ(居住中→空室) 登録値確認：特優賃上昇率');
		System.assertEquals(pr_before.SpecificExcellentRentSupportYears__c, pr.SpecificExcellentRentSupportYears__c, '物件データリアプロ(居住中→空室) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(pr_before.SpecificExcellentRentRemarks__c, pr.SpecificExcellentRentRemarks__c, '物件データリアプロ(居住中→空室) 登録値確認：特優賃備考');
		System.assertEquals(pr_before.ContractTermYear__c, pr.ContractTermYear__c, '物件データリアプロ(居住中→空室) 登録値確認：契約期間(年)');
		System.assertEquals(pr_before.ContractTermMonth__c, pr.ContractTermMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データリアプロ(居住中→空室) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データリアプロ(居住中→空室) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データリアプロ(居住中→空室) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(parkingFee, pr.ParkingFee__c, '物件データリアプロ(居住中→空室) 登録値確認：駐車場料金');
		System.assertEquals(parkingFeeTaxType, pr.ParkingFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データリアプロ(居住中→空室) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(keyPlace, pr.KeyPlace__c, '物件データリアプロ(居住中→空室) 登録値確認：鍵所在');
		System.assertEquals(rewardBurdenLender, pr.RewardBurdenLender__c, '物件データリアプロ(居住中→空室) 登録値確認：報酬負担貸主');
		System.assertEquals(rewardBurdenBorrower, pr.RewardBurdenBorrower__c, '物件データリアプロ(居住中→空室) 登録値確認：報酬負担借主');
		System.assertEquals(rewardSplitFormerSupplier, pr.RewardSplitFormerSupplier__c, '物件データリアプロ(居住中→空室) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データリアプロ(居住中→空室) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データリアプロ(居住中→空室) 登録値確認：広告料単位');
		System.assertEquals(ADFeeMonth, pr.ADFeeMonth__c, '物件データリアプロ(居住中→空室) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データリアプロ(居住中→空室) 登録値確認：広告料(%)');
		System.assertEquals(ADFeeTaxType, pr.ADFeeTaxType__c, '物件データリアプロ(居住中→空室) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データリアプロ(居住中→空室) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データリアプロ(居住中→空室) 登録値確認：広告備考(非公開)');
		System.assertEquals(null, pr.GarbageDisposalFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(null, pr.TownshipInitialFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：入町費税区分');
		System.assertEquals(null, pr.BicycleParkingFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(null, pr.ParkingDepositTaxType__c, '物件データリアプロ(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(null, pr.BikeParkingSmallFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkingMediumFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkinLargeFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + parkingFee, pr.RentFeeSearchParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + parkingFee, pr.RentFeeSearchManagementParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(LiveStatus, pr.LiveStatus__c, '物件データリアプロ(居住中→空室) 登録値確認：現況');
		System.assertEquals(webPublishing, pr.WebPublishing__c, '物件データリアプロ(居住中→空室) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データリアプロ(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データリアプロ(新規) 登録値確認：一括確認日');
		System.assertEquals(null, pr.OwnCompanyManageModDate__c, '物件データリアプロ(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データリアプロ(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データリアプロ(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c != null, '物件データリアプロ(新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データリアプロ(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 4:居住中→空室 大東建託
	// 物件データ登録値確認(居住中→空室)
	@isTest static void checkPropertyLivingChangeVacancyDaitoukentaku() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceDaitoukentaku();
		insert pr_AutoMainte;

		//更新前にデータを取得し、保持 
		Property__c pr_before= [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE_EXISTS
			LIMIT 1];

		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_LIVESTATUS_EMPTY,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_NO,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データ大東建託(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データ大東建託(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データ大東建託(居住中→空室) 登録値確認：取込先');
		System.assertEquals(null, pr.PropertyDetailUrl__c, '物件データ大東建託(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE_EXISTS, pr.MaintenancePropertyCode__c, '物件データ大東建託(居住中→空室) 登録値確認：メンテナンス物件コード');
		System.assertEquals(pr_before.Name, pr.Name, '物件データ大東建託(居住中→空室) 登録値確認：部屋番号');
		System.assertEquals(pr_before.Floor__c, pr.Floor__c, '物件データ大東建託(居住中→空室) 登録値確認：所在階');
		System.assertEquals(pr_before.BalconyDirection__c, pr.BalconyDirection__c, '物件データ大東建託(居住中→空室) 登録値確認：バルコニー方向');
		System.assertEquals(pr_before.RoomArea__c, pr.RoomArea__c, '物件データ大東建託(居住中→空室) 登録値確認：専有面積');
		System.assertEquals(pr_before.BalconyArea__c, pr.BalconyArea__c, '物件データ大東建託(居住中→空室) 登録値確認：バルコニー面積');
		System.assertEquals(pr_before.RoomCount__c, pr.RoomCount__c, '物件データ大東建託(居住中→空室) 登録値確認：部屋数');
		System.assertEquals(pr_before.RoomLayout__c, pr.RoomLayout__c, '物件データ大東建託(居住中→空室) 登録値確認：間取り');
		System.assertEquals(null, pr.TransactionAspect__c, '物件データ大東建託(新規) 登録値確認：取引態様');
		System.assertEquals(pr_before.DeliveryType__c, pr.DeliveryType__c, '物件データ大東建託(居住中→空室) 登録値確認：引渡種別');
		System.assertEquals(pr_before.DeliveryYear__c, pr.DeliveryYear__c, '物件データ大東建託(居住中→空室) 登録値確認：引渡 年');
		System.assertEquals(pr_before.DeliveryMonth__c, pr.DeliveryMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：引渡 月');
		System.assertEquals(pr_before.DeliveryDay__c, pr.DeliveryDay__c, '物件データ大東建託(居住中→空室) 登録値確認：引渡 日');
		System.assertEquals(pr_before.DeliveryTiming__c, pr.DeliveryTiming__c, '物件データ大東建託(居住中→空室) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データ大東建託(新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データ大東建託(新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データ大東建託(新規) 登録値確認：火災保険タイトル');
		System.assertEquals(null, pr.GuaranteeidCompanyType__c, '物件データ大東建託(居住中→空室) 登録値確認：保証会社(利用区分)');
		System.assertEquals(AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, pr.BicycleParkingType__c, '物件データ大東建託(居住中→空室) 登録値確認：駐輪場種別');
		System.assertEquals(AUTOMAINTEDIFF_BIKEYARD_NO, pr.BikeStorageType__c, '物件データ大東建託(居住中→空室) 登録値確認：バイク置場種別');
		System.assertEquals(deliveryConsultation, pr.DeliveryConsultation__c, '物件データ大東建託(居住中→空室) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(AUTOMAINTEDIFF_MOVEIN_EXISTS, pr.LivedType__c, '物件データ大東建託(居住中→空室) 登録値確認：未入居種別');
		System.assertEquals(renovationComplateYear, pr.RenovationComplateYear__c, '物件データ大東建託(居住中→空室) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(renovationComplateMonth, pr.RenovationComplateMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(renovationContent, pr.RenovationContent__c, '物件データ大東建託(居住中→空室) 登録値確認：リノベ施工内容');
		System.assertEquals(propertyRemarksPrivate, pr.PropertyRemarksPrivate__c, '物件データ大東建託(居住中→空室) 登録値確認：物件備考(非公開)');
		System.assertEquals(rentFee, pr.RentFee__c, '物件データ大東建託(居住中→空室) 登録値確認：賃料');
		System.assertEquals(managementFee, pr.ManagementFee__c, '物件データ大東建託(居住中→空室) 登録値確認：管理費');
		System.assertEquals(managementFeeTaxType, pr.ManagementFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：管理費税区分');
		System.assertEquals(securityDepositUnit, pr.SecurityDepositUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：敷金単位');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：敷金(ヶ月)');
		System.assertEquals(securityDepositMonth, pr.SecurityDepositMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYen__c, '物件データ大東建託(新規) 登録値確認：敷金(円)');
		System.assertEquals(securityDepositYen, pr.SecurityDepositYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(keyMoneyUnit, pr.KeyMoneyUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：礼金単位');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：礼金(ヵ月)');
		System.assertEquals(keyMoneyMonth, pr.KeyMoneyMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYen__c, '物件データ大東建託(居住中→空室) 登録値確認：礼金(円)');
		System.assertEquals(keyMoneyYen, pr.KeyMoneyYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(depositUnit, pr.DepositUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：保証金単位');
		System.assertEquals(depositMonth, pr.DepositMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(depositMonth, pr.DepositMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(depositYen, pr.DepositYen__c, '物件データ大東建託(居住中→空室) 登録値確認：保証料金(円)');
		System.assertEquals(depositYen, pr.DepositYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(cancellationActualFeeUnit, pr.CancellationActualFeeUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：敷引・償却単位');
		System.assertEquals(cancellationActualFeeMonth, pr.CancellationActualFeeMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(cancellationActualFeeRate, pr.CancellationActualFeeRate__c, '物件データ大東建託(居住中→空室) 登録値確認：敷引・償却(%)');
		System.assertEquals(cancellationActualFeeYen, pr.CancellationActualFeeYen__c, '物件データ大東建託(居住中→空室) 登録値確認：敷引・償却(円)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：更新料(ヵ月)');
		System.assertEquals(renewalFeeMonth, pr.RenewalFeeMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(renewalFeeUnit, pr.RenewalFeeUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：更新料単位');
		System.assertEquals(null, pr.RenewalFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：更新料税区分');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYen__c, '物件データ大東建託(居住中→空室) 登録値確認：更新料(円)');
		System.assertEquals(renewalFeeYen, pr.RenewalFeeYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(keyExchangeFee, pr.KeyExchangeFee__c, '物件データ大東建託(居住中→空室) 登録値確認：鍵交換費');
		System.assertEquals(null, pr.KeyExchangeFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：鍵交換費税区分');
		System.assertEquals(null, pr.WortFee__c, '物件データ大東建託(居住中→空室) 登録値確認：水道料金');
		System.assertEquals(null, pr.WortFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：水道料金税区分');
		System.assertEquals(townshipFee, pr.TownshipFee__c, '物件データ大東建託(居住中→空室) 登録値確認：町内会費');
		System.assertEquals(null, pr.TownshipFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：町内会費税区分');
		System.assertEquals(null, pr.TownshipFeePaymentType__c, '物件データ大東建託(居住中→空室) 登録値確認：町内会費支払区分');
		System.assertEquals(CATVFee, pr.CATVFee__c, '物件データ大東建託(居住中→空室) 登録値確認：CATV');
		System.assertEquals(null, pr.CATVTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：CATV税区分');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYen__c, '物件データ大東建託(居住中→空室) 登録値確認：定額修繕費(円)');
		System.assertEquals(cleaningFeeYen, pr.CleaningFeeYenSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(null, pr.CleaningFeeMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeMonth, pr.CleaningFeeMonthSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(cleaningFeeUnit, pr.CleaningFeeUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：定額修繕費単位');
		System.assertEquals(null, pr.CleaningFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：定額修繕費税区分');
		System.assertEquals(null, pr.CleaningFeePaymentType__c, '物件データ大東建託(居住中→空室) 登録値確認：定額修繕費支払区分');
		System.assertEquals(freeRentTermMonth, pr.FreeRentTermMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(freeRentContent, pr.FreeRentContent__c, '物件データ大東建託(居住中→空室) 登録値確認：フリーレント内容');
		System.assertEquals(specificExcellentRentBurdenUpperLimit, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データ大東建託(居住中→空室) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(specificExcellentRentBurdenLowerLimit, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データ大東建託(居住中→空室) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データ大東建託(居住中→空室) 登録値確認：特優賃料金変動区分');
		System.assertEquals(specificExcellentRentFeeUpwardRate, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データ大東建託(居住中→空室) 登録値確認：特優賃上昇率');
		System.assertEquals(specificExcellentRentSupportYears, pr.SpecificExcellentRentSupportYears__c, '物件データ大東建託(居住中→空室) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(specificExcellentRentRemarks, pr.SpecificExcellentRentRemarks__c, '物件データ大東建託(居住中→空室) 登録値確認：特優賃備考');
		System.assertEquals(contractTermYear, pr.ContractTermYear__c, '物件データ大東建託(居住中→空室) 登録値確認：契約期間(年)');
		System.assertEquals(contractTermMonth, pr.ContractTermMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：契約期間(月)');
		System.assertEquals(monetaryPrivate, pr.MonetaryPrivate__c, '物件データ大東建託(居住中→空室) 登録値確認：金銭備考(非公開)');
		System.assertEquals(parkingType, pr.ParkingType__c, '物件データ大東建託(居住中→空室) 登録値確認：駐車場種別');
		System.assertEquals(parkingDistance, pr.ParkingDistance__c, '物件データ大東建託(居住中→空室) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(parkingFee, pr.ParkingFee__c, '物件データ大東建託(居住中→空室) 登録値確認：駐車場料金');
		System.assertEquals(parkingFeeTaxType, pr.ParkingFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：駐車場料金税区分');
		System.assertEquals(parkingRemarksPrivate, pr.ParkingRemarksPrivate__c, '物件データ大東建託(居住中→空室) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(keyPlace, pr.KeyPlace__c, '物件データ大東建託(居住中→空室) 登録値確認：鍵所在');
		System.assertEquals(null, pr.RewardBurdenLender__c, '物件データ大東建託(居住中→空室) 登録値確認：報酬負担貸主');
		System.assertEquals(rewardBurdenBorrower, pr.RewardBurdenBorrower__c, '物件データ大東建託(居住中→空室) 登録値確認：報酬負担借主');
		System.assertEquals(null, pr.RewardSplitFormerSupplier__c, '物件データ大東建託(居住中→空室) 登録値確認：報酬配分元付');
		System.assertEquals(rewardSplitCustomer, pr.RewardSplitCustomer__c, '物件データ大東建託(居住中→空室) 登録値確認：報酬配分客付');
		System.assertEquals(ADFeeUnit, pr.ADFeeUnit__c, '物件データ大東建託(居住中→空室) 登録値確認：広告料単位');
		System.assertEquals(null, pr.ADFeeMonth__c, '物件データ大東建託(居住中→空室) 登録値確認：広告料(ヵ月)');
		System.assertEquals(ADFeeRate, pr.ADFeeRate__c, '物件データ大東建託(居住中→空室) 登録値確認：広告料(%)');
		System.assertEquals(null, pr.ADFeeTaxType__c, '物件データ大東建託(居住中→空室) 登録値確認：広告料税区分');
		System.assertEquals(ADFeeYen, pr.ADFeeYen__c, '物件データ大東建託(居住中→空室) 登録値確認：広告料(円)');
		System.assertEquals(ADRemarksPrivate, pr.ADRemarksPrivate__c, '物件データ大東建託(居住中→空室) 登録値確認：広告備考(非公開)');
		System.assertEquals(null, pr.GarbageDisposalFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(null, pr.TownshipInitialFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：入町費税区分');
		System.assertEquals(null, pr.BicycleParkingFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(null, pr.ParkingDepositTaxType__c, '物件データ大東建託(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(null, pr.BikeParkingSmallFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkingMediumFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkinLargeFeeTaxType__c, '物件データ大東建託(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(rentFee, pr.RentFeeSearch__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(rentFee + managementFee, pr.RentFeeSearchManagement__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(rentFee + parkingFee, pr.RentFeeSearchParking__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(rentFee + managementFee + parkingFee, pr.RentFeeSearchManagementParking__c, '物件データ大東建託(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals(LiveStatus, pr.LiveStatus__c, '物件データ大東建託(居住中→空室) 登録値確認：現況');
		System.assertEquals('しない', pr.WebPublishing__c, '物件データ大東建託(居住中→空室) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データ大東建託(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データ大東建託(新規) 登録値確認：一括確認日');
		System.assertEquals(null, pr.OwnCompanyManageModDate__c, '物件データ大東建託(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データ大東建託(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c != null, '物件データ大東建託(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データ大東建託(新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c != null, '物件データ大東建託(新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データ大東建託(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 5:掲載終了 リアプロ
	// 物件データ登録値確認(掲載終了)
	@isTest static void checkPropertyPostingEndRealnetpro() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceRealnetpro();
		insert pr_AutoMainte;

		//更新前にデータを取得し、保持 
		Property__c pr_before= [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE_EXISTS
			LIMIT 1];

		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE_EXISTS,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE_EXISTS,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE_EXISTS,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_NO,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE_EXISTS
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データリアプロ(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データリアプロ(掲載終了) 登録値確認：取込先');
		System.assertEquals(propertyDetailUrl, pr.PropertyDetailUrl__c, '物件データリアプロ(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(PROPERTY_MAINT_CODE_EXISTS, pr.MaintenancePropertyCode__c, '物件データリアプロ(掲載終了) 登録値確認：メンテナンス物件コード');
		System.assertEquals(pr_before.Name, pr.Name, '物件データリアプロ(掲載終了) 登録値確認：部屋番号');
		System.assertEquals(pr_before.Floor__c, pr.Floor__c, '物件データリアプロ(掲載終了) 登録値確認：所在階');
		System.assertEquals(pr_before.BalconyDirection__c, pr.BalconyDirection__c, '物件データリアプロ(掲載終了) 登録値確認：バルコニー方向');
		System.assertEquals(pr_before.RoomArea__c, pr.RoomArea__c, '物件データリアプロ(掲載終了) 登録値確認：専有面積');
		System.assertEquals(pr_before.BalconyArea__c, pr.BalconyArea__c, '物件データリアプロ(掲載終了) 登録値確認：バルコニー面積');
		System.assertEquals(pr_before.RoomCount__c, pr.RoomCount__c, '物件データリアプロ(掲載終了) 登録値確認：部屋数');
		System.assertEquals(pr_before.RoomLayout__c, pr.RoomLayout__c, '物件データリアプロ(掲載終了) 登録値確認：間取り');
		System.assertEquals(null, pr.TransactionAspect__c, '物件データリアプロ(新規) 登録値確認：取引態様');
		System.assertEquals(pr_before.DeliveryType__c, pr.DeliveryType__c, '物件データリアプロ(掲載終了) 登録値確認：引渡種別');
		System.assertEquals(pr_before.DeliveryYear__c, pr.DeliveryYear__c, '物件データリアプロ(掲載終了) 登録値確認：引渡 年');
		System.assertEquals(pr_before.DeliveryMonth__c, pr.DeliveryMonth__c, '物件データリアプロ(掲載終了) 登録値確認：引渡 月');
		System.assertEquals(pr_before.DeliveryDay__c, pr.DeliveryDay__c, '物件データリアプロ(掲載終了) 登録値確認：引渡 日');
		System.assertEquals(pr_before.DeliveryTiming__c, pr.DeliveryTiming__c, '物件データリアプロ(掲載終了) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データリアプロ(新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データリアプロ(新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データリアプロ(新規) 登録値確認：火災保険タイトル');
		System.assertEquals(pr_before.GuaranteeidCompanyType__c, pr.GuaranteeidCompanyType__c, '物件データリアプロ(掲載終了) 登録値確認：保証会社(利用区分)');
		System.assertEquals(pr_before.BicycleParkingType__c, pr.BicycleParkingType__c, '物件データリアプロ(掲載終了) 登録値確認：駐輪場種別');
		System.assertEquals(pr_before.BikeStorageType__c, pr.BikeStorageType__c, '物件データリアプロ(掲載終了) 登録値確認：バイク置場種別');
		System.assertEquals(pr_before.DeliveryConsultation__c, pr.DeliveryConsultation__c, '物件データリアプロ(掲載終了) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(pr_before.LivedType__c, pr.LivedType__c, '物件データリアプロ(掲載終了) 登録値確認：未入居種別');
		System.assertEquals(pr_before.RenovationComplateYear__c, pr.RenovationComplateYear__c, '物件データリアプロ(掲載終了) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(pr_before.RenovationComplateMonth__c, pr.RenovationComplateMonth__c, '物件データリアプロ(掲載終了) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(pr_before.RenovationContent__c, pr.RenovationContent__c, '物件データリアプロ(掲載終了) 登録値確認：リノベ施工内容');
		System.assertEquals(pr_before.PropertyRemarksPrivate__c, pr.PropertyRemarksPrivate__c, '物件データリアプロ(掲載終了) 登録値確認：物件備考(非公開)');
		System.assertEquals(pr_before.RentFee__c, pr.RentFee__c, '物件データリアプロ(掲載終了) 登録値確認：賃料');
		System.assertEquals(pr_before.ManagementFee__c, pr.ManagementFee__c, '物件データリアプロ(掲載終了) 登録値確認：管理費');
		System.assertEquals(pr_before.ManagementFeeTaxType__c, pr.ManagementFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：管理費税区分');
		System.assertEquals(pr_before.SecurityDepositUnit__c, pr.SecurityDepositUnit__c, '物件データリアプロ(掲載終了) 登録値確認：敷金単位');
		System.assertEquals(pr_before.SecurityDepositMonth__c, pr.SecurityDepositMonth__c, '物件データリアプロ(掲載終了) 登録値確認：敷金(ヶ月)');
		System.assertEquals(pr_before.SecurityDepositMonthSearch__c, pr.SecurityDepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(pr_before.SecurityDepositYen__c, pr.SecurityDepositYen__c, '物件データリアプロ(新規) 登録値確認：敷金(円)');
		System.assertEquals(pr_before.SecurityDepositYenSearch__c, pr.SecurityDepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(pr_before.KeyMoneyUnit__c, pr.KeyMoneyUnit__c, '物件データリアプロ(掲載終了) 登録値確認：礼金単位');
		System.assertEquals(pr_before.KeyMoneyMonth__c, pr.KeyMoneyMonth__c, '物件データリアプロ(掲載終了) 登録値確認：礼金(ヵ月)');
		System.assertEquals(pr_before.KeyMoneyMonthSearch__c, pr.KeyMoneyMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(pr_before.KeyMoneyYen__c, pr.KeyMoneyYen__c, '物件データリアプロ(掲載終了) 登録値確認：礼金(円)');
		System.assertEquals(pr_before.KeyMoneyYenSearch__c, pr.KeyMoneyYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(pr_before.DepositUnit__c, pr.DepositUnit__c, '物件データリアプロ(掲載終了) 登録値確認：保証金単位');
		System.assertEquals(pr_before.DepositMonth__c, pr.DepositMonth__c, '物件データリアプロ(掲載終了) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(pr_before.DepositMonthSearch__c, pr.DepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(pr_before.DepositYen__c, pr.DepositYen__c, '物件データリアプロ(掲載終了) 登録値確認：保証料金(円)');
		System.assertEquals(pr_before.DepositYenSearch__c, pr.DepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(pr_before.CancellationActualFeeUnit__c, pr.CancellationActualFeeUnit__c, '物件データリアプロ(掲載終了) 登録値確認：敷引・償却単位');
		System.assertEquals(pr_before.CancellationActualFeeMonth__c, pr.CancellationActualFeeMonth__c, '物件データリアプロ(掲載終了) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(pr_before.CancellationActualFeeRate__c, pr.CancellationActualFeeRate__c, '物件データリアプロ(掲載終了) 登録値確認：敷引・償却(%)');
		System.assertEquals(pr_before.CancellationActualFeeYen__c, pr.CancellationActualFeeYen__c, '物件データリアプロ(掲載終了) 登録値確認：敷引・償却(円)');
		System.assertEquals(pr_before.RenewalFeeMonth__c, pr.RenewalFeeMonth__c, '物件データリアプロ(掲載終了) 登録値確認：更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeMonthSearch__c, pr.RenewalFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeUnit__c, pr.RenewalFeeUnit__c, '物件データリアプロ(掲載終了) 登録値確認：更新料単位');
		System.assertEquals(pr_before.RenewalFeeTaxType__c, pr.RenewalFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：更新料税区分');
		System.assertEquals(pr_before.RenewalFeeYen__c, pr.RenewalFeeYen__c, '物件データリアプロ(掲載終了) 登録値確認：更新料(円)');
		System.assertEquals(pr_before.RenewalFeeYenSearch__c, pr.RenewalFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(pr_before.KeyExchangeFee__c, pr.KeyExchangeFee__c, '物件データリアプロ(掲載終了) 登録値確認：鍵交換費');
		System.assertEquals(pr_before.KeyExchangeFeeTaxType__c, pr.KeyExchangeFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：鍵交換費税区分');
		System.assertEquals(pr_before.WortFee__c, pr.WortFee__c, '物件データリアプロ(掲載終了) 登録値確認：水道料金');
		System.assertEquals(pr_before.WortFeeTaxType__c, pr.WortFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：水道料金税区分');
		System.assertEquals(pr_before.TownshipFee__c, pr.TownshipFee__c, '物件データリアプロ(掲載終了) 登録値確認：町内会費');
		System.assertEquals(pr_before.TownshipFeeTaxType__c, pr.TownshipFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：町内会費税区分');
		System.assertEquals(pr_before.TownshipFeePaymentType__c, pr.TownshipFeePaymentType__c, '物件データリアプロ(掲載終了) 登録値確認：町内会費支払区分');
		System.assertEquals(pr_before.CATVFee__c, pr.CATVFee__c, '物件データリアプロ(掲載終了) 登録値確認：CATV');
		System.assertEquals(pr_before.CATVTaxType__c, pr.CATVTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：CATV税区分');
		System.assertEquals(pr_before.CleaningFeeYen__c, pr.CleaningFeeYen__c, '物件データリアプロ(掲載終了) 登録値確認：定額修繕費(円)');
		System.assertEquals(pr_before.CleaningFeeYenSearch__c, pr.CleaningFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(pr_before.CleaningFeeMonth__c, pr.CleaningFeeMonth__c, '物件データリアプロ(掲載終了) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(pr_before.CleaningFeeMonthSearch__c, pr.CleaningFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(pr_before.CleaningFeeUnit__c, pr.CleaningFeeUnit__c, '物件データリアプロ(掲載終了) 登録値確認：定額修繕費単位');
		System.assertEquals(pr_before.CleaningFeeTaxType__c, pr.CleaningFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：定額修繕費税区分');
		System.assertEquals(pr_before.CleaningFeePaymentType__c, pr.CleaningFeePaymentType__c, '物件データリアプロ(掲載終了) 登録値確認：定額修繕費支払区分');
		System.assertEquals(pr_before.FreeRentTermMonth__c, pr.FreeRentTermMonth__c, '物件データリアプロ(掲載終了) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(pr_before.FreeRentContent__c, pr.FreeRentContent__c, '物件データリアプロ(掲載終了) 登録値確認：フリーレント内容');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenUpperLimit__c, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データリアプロ(掲載終了) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenLowerLimit__c, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データリアプロ(掲載終了) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(pr_before.SpecificExcellentRentFeeFluctuationType__c, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データリアプロ(掲載終了) 登録値確認：特優賃料金変動区分');
		System.assertEquals(pr_before.SpecificExcellentRentFeeUpwardRate__c, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データリアプロ(掲載終了) 登録値確認：特優賃上昇率');
		System.assertEquals(pr_before.SpecificExcellentRentSupportYears__c, pr.SpecificExcellentRentSupportYears__c, '物件データリアプロ(掲載終了) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(pr_before.SpecificExcellentRentRemarks__c, pr.SpecificExcellentRentRemarks__c, '物件データリアプロ(掲載終了) 登録値確認：特優賃備考');
		System.assertEquals(pr_before.ContractTermYear__c, pr.ContractTermYear__c, '物件データリアプロ(掲載終了) 登録値確認：契約期間(年)');
		System.assertEquals(pr_before.ContractTermMonth__c, pr.ContractTermMonth__c, '物件データリアプロ(掲載終了) 登録値確認：契約期間(月)');
		System.assertEquals(pr_before.MonetaryPrivate__c, pr.MonetaryPrivate__c, '物件データリアプロ(掲載終了) 登録値確認：金銭備考(非公開)');
		System.assertEquals(pr_before.ParkingType__c, pr.ParkingType__c, '物件データリアプロ(掲載終了) 登録値確認：駐車場種別');
		System.assertEquals(pr_before.ParkingDistance__c, pr.ParkingDistance__c, '物件データリアプロ(掲載終了) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(pr_before.ParkingFee__c, pr.ParkingFee__c, '物件データリアプロ(掲載終了) 登録値確認：駐車場料金');
		System.assertEquals(pr_before.ParkingFeeTaxType__c, pr.ParkingFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：駐車場料金税区分');
		System.assertEquals(pr_before.ParkingRemarksPrivate__c, pr.ParkingRemarksPrivate__c, '物件データリアプロ(掲載終了) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(pr_before.KeyPlace__c, pr.KeyPlace__c, '物件データリアプロ(掲載終了) 登録値確認：鍵所在');
		System.assertEquals(pr_before.RewardBurdenLender__c, pr.RewardBurdenLender__c, '物件データリアプロ(掲載終了) 登録値確認：報酬負担貸主');
		System.assertEquals(pr_before.RewardBurdenBorrower__c, pr.RewardBurdenBorrower__c, '物件データリアプロ(掲載終了) 登録値確認：報酬負担借主');
		System.assertEquals(pr_before.RewardSplitFormerSupplier__c, pr.RewardSplitFormerSupplier__c, '物件データリアプロ(掲載終了) 登録値確認：報酬配分元付');
		System.assertEquals(pr_before.RewardSplitCustomer__c, pr.RewardSplitCustomer__c, '物件データリアプロ(掲載終了) 登録値確認：報酬配分客付');
		System.assertEquals(pr_before.ADFeeUnit__c, pr.ADFeeUnit__c, '物件データリアプロ(掲載終了) 登録値確認：広告料単位');
		System.assertEquals(pr_before.ADFeeMonth__c, pr.ADFeeMonth__c, '物件データリアプロ(掲載終了) 登録値確認：広告料(ヵ月)');
		System.assertEquals(pr_before.ADFeeRate__c, pr.ADFeeRate__c, '物件データリアプロ(掲載終了) 登録値確認：広告料(%)');
		System.assertEquals(pr_before.ADFeeTaxType__c, pr.ADFeeTaxType__c, '物件データリアプロ(掲載終了) 登録値確認：広告料税区分');
		System.assertEquals(pr_before.ADFeeYen__c, pr.ADFeeYen__c, '物件データリアプロ(掲載終了) 登録値確認：広告料(円)');
		System.assertEquals(pr_before.ADRemarksPrivate__c, pr.ADRemarksPrivate__c, '物件データリアプロ(掲載終了) 登録値確認：広告備考(非公開)');
		System.assertEquals(null, pr.GarbageDisposalFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(null, pr.TownshipInitialFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：入町費税区分');
		System.assertEquals(null, pr.BicycleParkingFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(null, pr.ParkingDepositTaxType__c, '物件データリアプロ(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(null, pr.BikeParkingSmallFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkingMediumFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkinLargeFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(pr_before.RentFeeSearch__c, pr.RentFeeSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(pr_before.RentFeeSearchManagement__c, pr.RentFeeSearchManagement__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(pr_before.RentFeeSearchParking__c, pr.RentFeeSearchParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(pr_before.RentFeeSearchManagementParking__c, pr.RentFeeSearchManagementParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals('居住中', pr.LiveStatus__c, '物件データリアプロ(掲載終了) 登録値確認：現況');
		System.assertEquals('しない', pr.WebPublishing__c, '物件データリアプロ(掲載終了) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データリアプロ(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データリアプロ(新規) 登録値確認：一括確認日');
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.OwnCompanyManageModDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データリアプロ(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c == null, '物件データリアプロ(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c == null, '物件データリアプロ(新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データリアプロ(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}

	// 5:掲載終了 大東建託
	// 物件データ登録値確認(掲載終了)
	@isTest static void checkPropertyPostingEndDaitoukentaku() {
		// 新規
		Property__c pr_AutoMainte = SetPropertyAutoMaintenanceDaitoukentaku();
		insert pr_AutoMainte;

		//更新前にデータを取得し、保持 
		Property__c pr_before= [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE
			LIMIT 1];

		Datetime crawlingDataModifiedDate = CommonUtil.getNow();				// クローリングデータ更新日 2022/6/24 項目追加
		String importType   = CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;		// 取込区分
		String propertyDetailUrl = 'test';										// 物件詳細画面URL 2022/6/24 項目追加
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU;	// 外部サイトコード
		String propertyName = 'リアプロメンテ物件';								// 部屋番号
		Decimal floor = 100;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.45;												// 専有面積
		Decimal balconyArea = 978.65;											// バルコニー面積
		Decimal roomCount = 99;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2020';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '01';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 10;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)';						// 物件備考(非公開)
		Decimal rentFee = 1234567;												// 賃料
		Decimal managementFee = 123456;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 1111111;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 2222222;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 3333333;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 4444444;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 5555555;										// 更新料(円)
		Decimal keyExchangeFee = 666666;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 777777;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 888888;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 9999999;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 1111111;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 6;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 999999;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 111111;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 25;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 10;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考';						// 特優賃備考
		Decimal contractTermYear = 22;											// 契約期間（年）
		Decimal contractTermMonth = 10;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 22222;												// 近隣駐車場までの距離
		Decimal parkingFee = 333333;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在';														// 鍵所在
		Decimal rewardBurdenLender = 4.44;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 5.55;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 6.66;										// 報酬配分元付
		Decimal rewardSplitCustomer = 7.77;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 1111111111;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierState            = '愛知県';
		String supplierCity             = '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許';
		String supplierStaffName        = '洞口 太郎';
		String supplierCompanyRemarks   = '管理会社備考';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;


		// 自動メンテナンス差分作成(トリガー起動)
		t_auto_maintenance_difference__c autoMainteDiff = new t_auto_maintenance_difference__c(
			InfoModifiedDate__c				= crawlingDataModifiedDate,		// 2022/6/24 項目追加
			AutoMaintenanceType__c          = CommonConst.AUTOMAINTEDIFF_AUTOMAINTETYPE_POSTING_END,
			PropertyDetailUrl__c			= propertyDetailUrl,			// 2022/6/24 項目追加
			MaintenanceBuildingCode__c      = BUILDING_MAINT_CODE,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			MaintenanceSupplierCode__c      = SUPPLIER_MAINT_CODE,
			BuildingName__c                 = '自動メンテ建物',
			PropertyName__c                 = propertyName,
			ExternalSiteCd__c               = externalSiteCd,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			LiveStatus__c                   = liveStatus,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			// ▼2022/5/27 項目追加 大東建託連携
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_NO, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_NO,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			// ▲2022/5/27
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			// ▼2022/5/27 項目追加 大東建託連携
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			// ▲2022/5/27
			MonetaryRemarksPrivate__c       = monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			// ▼2022/6/2 テスト項目追加 大東建託連携
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			// ▲2022/6/2
			ADRemarksPrivate__c             = ADRemarksPrivate,
			WebPublishing__c				= webPublishing,
			ManagementCompanyName__c        = supplierName,
			ManagementCompanyAddress__c     = supplierAccress,
			ManagementCompanyPhone__c       = supplierPhone,
			ManagementCompanyFax__c         = supplierFax,
			ManagementCompanyLicense__c     = supplierLicense,
			ManagementCompanyStaffName__c   = supplierStaffName,
			ManagementCompanyRemarks__c     = supplierCompanyRemarks,
			AutoMaintenanceContent__c		= 'メンテナンスコメント',	// 2022/6/24 項目追加　メンテナンスコメント
			RoomLayoutFileName__c			= DIFF_ROOMLAYOUT_FILE_NAME_INIT1, // 2022/6/24/項目追加　自動メンテナンス差分間取図ファイル名
			ExcecuteBatchNo__c              = 1
		);
		insert autoMainteDiff;

		//バッチ実行
		Test.startTest();
		BD601005Batch batch = new BD601005Batch();
		Database.executeBatch(batch, 1);
		Test.stopTest();

		// 登録値確認
		Property__c pr = [
			SELECT
				Id,
				AutoMaintenanceDate__c,						// 自動最終メンテナンス日
				CrawlingDataModifiedDate__c,				// クローリングデータ更新日
				ImportType__c,								// 取込先
				PropertyDetailUrl__c,						// 物件詳細URL
				Building__c,								// 建物ID
				MaintenancePropertyCode__c,					// メンテナンス物件コード
				Name,										// 部屋番号
				Floor__c,									// 所在階
				BalconyDirection__c,						// バルコニー方向
				RoomArea__c,								// 専有面積
				BalconyArea__c,								// バルコニー面積
				RoomCount__c,								// 部屋数
				RoomLayout__c,								// 間取り
				TransactionAspect__c,						// 取引態様
				DeliveryType__c,							// 引渡種別
				DeliveryYear__c,							// 引渡 年
				DeliveryMonth__c,							// 引渡 月
				DeliveryDay__c,								// 引渡 日
				DeliveryTiming__c,							// 引渡 旬
				FormerSupplier__c,							// 元付業者
				FireInsuranceUseType__c,					// 火災保険(加入義務)
				FireInsuranceCompany__c,					// 火災保険会社
				FireInsurancePlan__c,						// 火災保険タイトル
				GuaranteeidCompany__c,						// 保証会社
				Guaranteeid__c,								// 保証タイトル
				BicycleParkingType__c,						// 駐輪場種別
				BikeStorageType__c,							// バイク置場種別
				DeliveryConsultation__c,					// 引渡・入居日(相談内容)
				LivedType__c,								// 未入居種別
				RenovationComplateYear__c,					// リノベ施工完了(年)
				RenovationComplateMonth__c,					// リノベ施工完了(月)
				RenovationContent__c,						// リノベ施工内容
				PropertyRemarksPrivate__c,					// 物件備考(非公開)
				RentFee__c,									// 賃料
				ManagementFee__c,							// 管理費
				ManagementFeeTaxType__c,					// 管理費税区分
				SecurityDepositUnit__c,						// 敷金単位
				SecurityDepositMonth__c,					// 敷金(ヶ月)
				SecurityDepositMonthSearch__c,				// (検索用)敷金(ヵ月)
				SecurityDepositYen__c,						// 敷金(円)
				SecurityDepositYenSearch__c,				// (検索用)敷金(円)
				KeyMoneyUnit__c,							// 礼金単位
				KeyMoneyMonth__c,							// 礼金(ヶ月)
				KeyMoneyMonthSearch__c,						// (検索用)礼金(ヵ月)
				KeyMoneyYen__c,								// 礼金(円)
				KeyMoneyYenSearch__c,						// (検索用)礼金(円)
				DepositUnit__c,								// 保証金単位
				DepositMonth__c,							// 保証料金(ヶ月)
				DepositMonthSearch__c,						// (検索用)保証料金(ヵ月)
				DepositYen__c,								// 保証料金(円)
				DepositYenSearch__c,						// (検索用)保証料金(円)
				CancellationActualFeeUnit__c,				// 敷引・償却単位
				CancellationActualFeeMonth__c,				// 敷引・償却(ヶ月)
				CancellationActualFeeRate__c,				// 敷引・償却(%)
				CancellationActualFeeYen__c,				// 敷引・償却(円)
				RenewalFeeMonth__c,							// 更新料(ヶ月)
				RenewalFeeMonthSearch__c,					// (検索用)更新料(ヵ月)
				RenewalFeeUnit__c,							// 更新料単位
				RenewalFeeTaxType__c,						// 更新料税区分
				RenewalFeeYen__c,							// 更新料(円)
				RenewalFeeYenSearch__c,						// (検索用)更新料(円)
				KeyExchangeFee__c,							// 鍵交換費
				KeyExchangeFeeTaxType__c,					// 鍵交換費税区分
				WortFee__c,									// 水道料金
				WortFeeTaxType__c,							// 水道料金区分
				TownshipFee__c,								// 町内会費
				TownshipFeeTaxType__c,						// 町内会費税区分
				TownshipFeePaymentType__c,					// 町内会費支払区分
				CATVFee__c,									// CATV
				CATVTaxType__c,								// CATV税区分
				CleaningFeeYen__c,							// 定額修繕費(円)
				CleaningFeeYenSearch__c,					// (検索用)定額修繕費(円)
				CleaningFeeMonth__c,						// 定額修繕費(ヶ月)
				CleaningFeeMonthSearch__c,					// (検索用)定額修繕費(ヵ月)
				CleaningFeeUnit__c,							// 定額修繕費単位
				CleaningFeeTaxType__c,						// 定額修繕費税区分
				CleaningFeePaymentType__c,					// 定額修繕費支払区分
				GuaranteeidCompanyType__c,					// 保証会社(利用区分)
				FreeRentTermMonth__c,						// フリーレント期間(ヶ月)
				FreeRentContent__c,							// フリーレント内容
				SpecificExcellentRentBurdenUpperLimit__c,	// 特優賃入居負担額上限
				SpecificExcellentRentBurdenLowerLimit__c,	// 特優賃入居負担額下限
				SpecificExcellentRentFeeFluctuationType__c,	// 特優賃料金変動区分
				SpecificExcellentRentFeeUpwardRate__c,		// 特優賃上昇率
				SpecificExcellentRentSupportYears__c,		// 特優賃家賃補助年数
				SpecificExcellentRentRemarks__c,			// 特優賃備考
				ContractTermYear__c,						// 契約期間(年)
				ContractTermMonth__c,						// 契約期間(月)
				MonetaryPrivate__c,							// 金銭備考(非公開)
				ParkingType__c,								// 駐車場種別
				ParkingDistance__c,							// 近隣駐車場までの距離
				ParkingFee__c,								// 駐車場料金
				ParkingFeeTaxType__c,						// 駐車場料金税区分
				ParkingRemarksPrivate__c,					// 駐車場備考(非公開)
				KeyPlace__c,								// 鍵所在
				RewardBurdenLender__c,						// 報酬負担貸主
				RewardBurdenBorrower__c,					// 報酬負担借主
				RewardSplitFormerSupplier__c,				// 報酬配分元付
				RewardSplitCustomer__c,						// 報酬配分客付
				ADFeeUnit__c,								// 広告料単位
				ADFeeMonth__c,								// 広告料(ヵ月)
				ADFeeRate__c,								// 広告料(%)
				ADFeeTaxType__c,							// 広告料税区分
				ADFeeYen__c,								// 広告料(円)
				ADRemarksPrivate__c,						// 広告備考(非公開)
				GarbageDisposalFeeTaxType__c,				// ごみ処理費税区分
				TownshipInitialFeeTaxType__c,				// 入町費税区分
				BicycleParkingFeeTaxType__c,				// 駐輪場代税区分
				ParkingDepositTaxType__c,					// 駐車場保証料金税区分
				ParkingCompoundingFeeTaxType__c,			// 駐車場手数料税区分
				BikeParkingSmallFeeTaxType__c,				// 小型バイク置場料金税区分
				BikeParkingMediumFeeTaxType__c,				// 中型バイク置場料金税区分
				BikeParkinLargeFeeTaxType__c,				// 大型バイク置場料金税区分
				RentFeeSearch__c,							// (検索用)賃料
				RentFeeSearchManagement__c,					// (検索用)賃料管理費込
				RentFeeSearchParking__c,					// (検索用)賃料駐車場込
				RentFeeSearchManagementParking__c,			// (検索用)賃料管理費駐車場込
				LiveStatus__c,								// 現況
				WebPublishing__c,							// web公開
				IsBulkConfirmation__c,						// 一括確認チェック
				BulkConfirmationDate__c,					// 一括確認日
				OwnCompanyManageModDate__c,					// 自社管理修正日
				TemporarySaveDate__c,						// 一時保存日
				MaintenanceType__c,							// メンテナンス区分
				MaintenanceCommentArea__c,					// メンテナンスコメント
				AllRentFee__c,								// 総賃料
				IsMergeCompletedFlag__c,					// 名寄せ完了フラグ
				Score__c,									// 点数
				AutoMaintenanceDiffRoomLayoutFileName__c	// 自動メンテナンス差分間取図ファイル名
			FROM Property__c 
			WHERE MaintenancePropertyCode__c =:PROPERTY_MAINT_CODE
			LIMIT 1];
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.AutoMaintenanceDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自動最終メンテンナンス日');
		System.assertEquals(crawlingDataModifiedDate, pr.CrawlingDataModifiedDate__c, '物件データリアプロ(新規) 登録値確認：クローリングデータ更新日');
		System.assertEquals(importType, pr.ImportType__c, '物件データ大東建託(掲載終了) 登録値確認：取込先');
		System.assertEquals(null, pr.PropertyDetailUrl__c, '物件データリアプロ(新規) 登録値確認：物件詳細画面URL');
		System.assertEquals(pr_before.MaintenancePropertyCode__c, pr.MaintenancePropertyCode__c, '物件データ大東建託(掲載終了) 登録値確認：メンテナンス物件コード');
		System.assertEquals(pr_before.Name, pr.Name, '物件データ大東建託(掲載終了) 登録値確認：部屋番号');
		System.assertEquals(pr_before.Floor__c, pr.Floor__c, '物件データ大東建託(掲載終了) 登録値確認：所在階');
		System.assertEquals(pr_before.BalconyDirection__c, pr.BalconyDirection__c, '物件データ大東建託(掲載終了) 登録値確認：バルコニー方向');
		System.assertEquals(pr_before.RoomArea__c, pr.RoomArea__c, '物件データ大東建託(掲載終了) 登録値確認：専有面積');
		System.assertEquals(pr_before.BalconyArea__c, pr.BalconyArea__c, '物件データ大東建託(掲載終了) 登録値確認：バルコニー面積');
		System.assertEquals(pr_before.RoomCount__c, pr.RoomCount__c, '物件データ大東建託(掲載終了) 登録値確認：部屋数');
		System.assertEquals(pr_before.RoomLayout__c, pr.RoomLayout__c, '物件データ大東建託(掲載終了) 登録値確認：間取り');
		System.assertEquals(null, pr.TransactionAspect__c, '物件データリアプロ(新規) 登録値確認：取引態様');
		System.assertEquals(pr_before.DeliveryType__c, pr.DeliveryType__c, '物件データ大東建託(掲載終了) 登録値確認：引渡種別');
		System.assertEquals(pr_before.DeliveryYear__c, pr.DeliveryYear__c, '物件データ大東建託(掲載終了) 登録値確認：引渡 年');
		System.assertEquals(pr_before.DeliveryMonth__c, pr.DeliveryMonth__c, '物件データ大東建託(掲載終了) 登録値確認：引渡 月');
		System.assertEquals(pr_before.DeliveryDay__c, pr.DeliveryDay__c, '物件データ大東建託(掲載終了) 登録値確認：引渡 日');
		System.assertEquals(pr_before.DeliveryTiming__c, pr.DeliveryTiming__c, '物件データ大東建託(掲載終了) 登録値確認：引渡 旬');
		System.assertEquals(null, pr.FireInsuranceUseType__c, '物件データリアプロ(新規) 登録値確認：火災保険(加入義務)');
		System.assertEquals(null, pr.FireInsuranceCompany__c, '物件データリアプロ(新規) 登録値確認：火災保険会社');
		System.assertEquals(null, pr.FireInsurancePlan__c, '物件データリアプロ(新規) 登録値確認：火災保険タイトル');
		System.assertEquals(pr_before.GuaranteeidCompanyType__c, pr.GuaranteeidCompanyType__c, '物件データ大東建託(掲載終了) 登録値確認：保証会社(利用区分)');
		System.assertEquals(pr_before.BicycleParkingType__c, pr.BicycleParkingType__c, '物件データ大東建託(掲載終了) 登録値確認：駐輪場種別');
		System.assertEquals(pr_before.BikeStorageType__c, pr.BikeStorageType__c, '物件データ大東建託(掲載終了) 登録値確認：バイク置場種別');
		System.assertEquals(pr_before.DeliveryConsultation__c, pr.DeliveryConsultation__c, '物件データ大東建託(掲載終了) 登録値確認：引渡・入居日(相談内容)');
		System.assertEquals(pr_before.LivedType__c, pr.LivedType__c, '物件データ大東建託(掲載終了) 登録値確認：未入居種別');
		System.assertEquals(pr_before.RenovationComplateYear__c, pr.RenovationComplateYear__c, '物件データ大東建託(掲載終了) 登録値確認：リノベ施工完了(年)');
		System.assertEquals(pr_before.RenovationComplateMonth__c, pr.RenovationComplateMonth__c, '物件データ大東建託(掲載終了) 登録値確認：リノベ施工完了(月)');
		System.assertEquals(pr_before.RenovationContent__c, pr.RenovationContent__c, '物件データ大東建託(掲載終了) 登録値確認：リノベ施工内容');
		System.assertEquals(pr_before.PropertyRemarksPrivate__c, pr.PropertyRemarksPrivate__c, '物件データ大東建託(掲載終了) 登録値確認：物件備考(非公開)');
		System.assertEquals(pr_before.RentFee__c, pr.RentFee__c, '物件データ大東建託(掲載終了) 登録値確認：賃料');
		System.assertEquals(pr_before.ManagementFee__c, pr.ManagementFee__c, '物件データ大東建託(掲載終了) 登録値確認：管理費');
		System.assertEquals(pr_before.ManagementFeeTaxType__c, pr.ManagementFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：管理費税区分');
		System.assertEquals(pr_before.SecurityDepositUnit__c, pr.SecurityDepositUnit__c, '物件データ大東建託(掲載終了) 登録値確認：敷金単位');
		System.assertEquals(pr_before.SecurityDepositMonth__c, pr.SecurityDepositMonth__c, '物件データ大東建託(掲載終了) 登録値確認：敷金(ヶ月)');
		System.assertEquals(pr_before.SecurityDepositMonthSearch__c, pr.SecurityDepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(ヵ月)');
		System.assertEquals(pr_before.SecurityDepositYen__c, pr.SecurityDepositYen__c, '物件データリアプロ(新規) 登録値確認：敷金(円)');
		System.assertEquals(pr_before.SecurityDepositYenSearch__c, pr.SecurityDepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)敷金(円)');
		System.assertEquals(pr_before.KeyMoneyUnit__c, pr.KeyMoneyUnit__c, '物件データ大東建託(掲載終了) 登録値確認：礼金単位');
		System.assertEquals(pr_before.KeyMoneyMonth__c, pr.KeyMoneyMonth__c, '物件データ大東建託(掲載終了) 登録値確認：礼金(ヵ月)');
		System.assertEquals(pr_before.KeyMoneyMonthSearch__c, pr.KeyMoneyMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(ヵ月)');
		System.assertEquals(pr_before.KeyMoneyYen__c, pr.KeyMoneyYen__c, '物件データ大東建託(掲載終了) 登録値確認：礼金(円)');
		System.assertEquals(pr_before.KeyMoneyYenSearch__c, pr.KeyMoneyYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)礼金(円)');
		System.assertEquals(pr_before.DepositUnit__c, pr.DepositUnit__c, '物件データ大東建託(掲載終了) 登録値確認：保証金単位');
		System.assertEquals(pr_before.DepositMonth__c, pr.DepositMonth__c, '物件データ大東建託(掲載終了) 登録値確認：保証料金(ヵ月)');
		System.assertEquals(pr_before.DepositMonthSearch__c, pr.DepositMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(ヵ月)');
		System.assertEquals(pr_before.DepositYen__c, pr.DepositYen__c, '物件データ大東建託(掲載終了) 登録値確認：保証料金(円)');
		System.assertEquals(pr_before.DepositYenSearch__c, pr.DepositYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)保証料金(円)');
		System.assertEquals(pr_before.CancellationActualFeeUnit__c, pr.CancellationActualFeeUnit__c, '物件データ大東建託(掲載終了) 登録値確認：敷引・償却単位');
		System.assertEquals(pr_before.CancellationActualFeeMonth__c, pr.CancellationActualFeeMonth__c, '物件データ大東建託(掲載終了) 登録値確認：敷引・償却(ヵ月)');
		System.assertEquals(pr_before.CancellationActualFeeRate__c, pr.CancellationActualFeeRate__c, '物件データ大東建託(掲載終了) 登録値確認：敷引・償却(%)');
		System.assertEquals(pr_before.CancellationActualFeeYen__c, pr.CancellationActualFeeYen__c, '物件データ大東建託(掲載終了) 登録値確認：敷引・償却(円)');
		System.assertEquals(pr_before.RenewalFeeMonth__c, pr.RenewalFeeMonth__c, '物件データ大東建託(掲載終了) 登録値確認：更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeMonthSearch__c, pr.RenewalFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(ヵ月)');
		System.assertEquals(pr_before.RenewalFeeUnit__c, pr.RenewalFeeUnit__c, '物件データ大東建託(掲載終了) 登録値確認：更新料単位');
		System.assertEquals(pr_before.RenewalFeeTaxType__c, pr.RenewalFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：更新料税区分');
		System.assertEquals(pr_before.RenewalFeeYen__c, pr.RenewalFeeYen__c, '物件データ大東建託(掲載終了) 登録値確認：更新料(円)');
		System.assertEquals(pr_before.RenewalFeeYenSearch__c, pr.RenewalFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)更新料(円)');
		System.assertEquals(pr_before.KeyExchangeFee__c, pr.KeyExchangeFee__c, '物件データ大東建託(掲載終了) 登録値確認：鍵交換費');
		System.assertEquals(pr_before.KeyExchangeFeeTaxType__c, pr.KeyExchangeFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：鍵交換費税区分');
		System.assertEquals(pr_before.WortFee__c, pr.WortFee__c, '物件データ大東建託(掲載終了) 登録値確認：水道料金');
		System.assertEquals(pr_before.WortFeeTaxType__c, pr.WortFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：水道料金税区分');
		System.assertEquals(pr_before.TownshipFee__c, pr.TownshipFee__c, '物件データ大東建託(掲載終了) 登録値確認：町内会費');
		System.assertEquals(pr_before.TownshipFeeTaxType__c, pr.TownshipFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：町内会費税区分');
		System.assertEquals(pr_before.TownshipFeePaymentType__c, pr.TownshipFeePaymentType__c, '物件データ大東建託(掲載終了) 登録値確認：町内会費支払区分');
		System.assertEquals(pr_before.CATVFee__c, pr.CATVFee__c, '物件データ大東建託(掲載終了) 登録値確認：CATV');
		System.assertEquals(pr_before.CATVTaxType__c, pr.CATVTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：CATV税区分');
		System.assertEquals(pr_before.CleaningFeeYen__c, pr.CleaningFeeYen__c, '物件データ大東建託(掲載終了) 登録値確認：定額修繕費(円)');
		System.assertEquals(pr_before.CleaningFeeYenSearch__c, pr.CleaningFeeYenSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(円)');
		System.assertEquals(pr_before.CleaningFeeMonth__c, pr.CleaningFeeMonth__c, '物件データ大東建託(掲載終了) 登録値確認：定額修繕費(ヵ月)');
		System.assertEquals(pr_before.CleaningFeeMonthSearch__c, pr.CleaningFeeMonthSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)定額修繕費(ヵ月)');
		System.assertEquals(pr_before.CleaningFeeUnit__c, pr.CleaningFeeUnit__c, '物件データ大東建託(掲載終了) 登録値確認：定額修繕費単位');
		System.assertEquals(pr_before.CleaningFeeTaxType__c, pr.CleaningFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：定額修繕費税区分');
		System.assertEquals(pr_before.CleaningFeePaymentType__c, pr.CleaningFeePaymentType__c, '物件データ大東建託(掲載終了) 登録値確認：定額修繕費支払区分');
		System.assertEquals(pr_before.FreeRentTermMonth__c, pr.FreeRentTermMonth__c, '物件データ大東建託(掲載終了) 登録値確認：フリーレント期間(ヶ月)');
		System.assertEquals(pr_before.FreeRentContent__c, pr.FreeRentContent__c, '物件データ大東建託(掲載終了) 登録値確認：フリーレント内容');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenUpperLimit__c, pr.SpecificExcellentRentBurdenUpperLimit__c, '物件データ大東建託(掲載終了) 登録値確認：特優賃入居負担額上限');
		System.assertEquals(pr_before.SpecificExcellentRentBurdenLowerLimit__c, pr.SpecificExcellentRentBurdenLowerLimit__c, '物件データ大東建託(掲載終了) 登録値確認：特優賃入居負担額下限');
		System.assertEquals(pr_before.SpecificExcellentRentFeeFluctuationType__c, pr.SpecificExcellentRentFeeFluctuationType__c, '物件データ大東建託(掲載終了) 登録値確認：特優賃料金変動区分');
		System.assertEquals(pr_before.SpecificExcellentRentFeeUpwardRate__c, pr.SpecificExcellentRentFeeUpwardRate__c, '物件データ大東建託(掲載終了) 登録値確認：特優賃上昇率');
		System.assertEquals(pr_before.SpecificExcellentRentSupportYears__c, pr.SpecificExcellentRentSupportYears__c, '物件データ大東建託(掲載終了) 登録値確認：特優賃家賃補助年数');
		System.assertEquals(pr_before.SpecificExcellentRentRemarks__c, pr.SpecificExcellentRentRemarks__c, '物件データ大東建託(掲載終了) 登録値確認：特優賃備考');
		System.assertEquals(pr_before.ContractTermYear__c, pr.ContractTermYear__c, '物件データ大東建託(掲載終了) 登録値確認：契約期間(年)');
		System.assertEquals(pr_before.ContractTermMonth__c, pr.ContractTermMonth__c, '物件データ大東建託(掲載終了) 登録値確認：契約期間(月)');
		System.assertEquals(pr_before.MonetaryPrivate__c, pr.MonetaryPrivate__c, '物件データ大東建託(掲載終了) 登録値確認：金銭備考(非公開)');
		System.assertEquals(pr_before.ParkingType__c, pr.ParkingType__c, '物件データ大東建託(掲載終了) 登録値確認：駐車場種別');
		System.assertEquals(pr_before.ParkingDistance__c, pr.ParkingDistance__c, '物件データ大東建託(掲載終了) 登録値確認：近隣駐車場までの距離');
		System.assertEquals(pr_before.ParkingFee__c, pr.ParkingFee__c, '物件データ大東建託(掲載終了) 登録値確認：駐車場料金');
		System.assertEquals(pr_before.ParkingFeeTaxType__c, pr.ParkingFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：駐車場料金税区分');
		System.assertEquals(pr_before.ParkingRemarksPrivate__c, pr.ParkingRemarksPrivate__c, '物件データ大東建託(掲載終了) 登録値確認：駐車場備考(非公開)');
		System.assertEquals(pr_before.KeyPlace__c, pr.KeyPlace__c, '物件データ大東建託(掲載終了) 登録値確認：鍵所在');
		System.assertEquals(pr_before.RewardBurdenLender__c, pr.RewardBurdenLender__c, '物件データ大東建託(掲載終了) 登録値確認：報酬負担貸主');
		System.assertEquals(pr_before.RewardBurdenBorrower__c, pr.RewardBurdenBorrower__c, '物件データ大東建託(掲載終了) 登録値確認：報酬負担借主');
		System.assertEquals(pr_before.RewardSplitFormerSupplier__c, pr.RewardSplitFormerSupplier__c, '物件データ大東建託(掲載終了) 登録値確認：報酬配分元付');
		System.assertEquals(pr_before.RewardSplitCustomer__c, pr.RewardSplitCustomer__c, '物件データ大東建託(掲載終了) 登録値確認：報酬配分客付');
		System.assertEquals(pr_before.ADFeeUnit__c, pr.ADFeeUnit__c, '物件データ大東建託(掲載終了) 登録値確認：広告料単位');
		System.assertEquals(pr_before.ADFeeMonth__c, pr.ADFeeMonth__c, '物件データ大東建託(掲載終了) 登録値確認：広告料(ヵ月)');
		System.assertEquals(pr_before.ADFeeRate__c, pr.ADFeeRate__c, '物件データ大東建託(掲載終了) 登録値確認：広告料(%)');
		System.assertEquals(pr_before.ADFeeTaxType__c, pr.ADFeeTaxType__c, '物件データ大東建託(掲載終了) 登録値確認：広告料税区分');
		System.assertEquals(pr_before.ADFeeYen__c, pr.ADFeeYen__c, '物件データ大東建託(掲載終了) 登録値確認：広告料(円)');
		System.assertEquals(pr_before.ADRemarksPrivate__c, pr.ADRemarksPrivate__c, '物件データ大東建託(掲載終了) 登録値確認：広告備考(非公開)');
		System.assertEquals(null, pr.GarbageDisposalFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：ごみ処理費税区分');
		System.assertEquals(null, pr.TownshipInitialFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：入町費税区分');
		System.assertEquals(null, pr.BicycleParkingFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：駐輪場代税区分');
		System.assertEquals(null, pr.ParkingDepositTaxType__c, '物件データリアプロ(新規) 登録値確認：駐車場保証料金税区分');
		System.assertEquals(null, pr.BikeParkingSmallFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：小型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkingMediumFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：中型バイク置場料金税区分');
		System.assertEquals(null, pr.BikeParkinLargeFeeTaxType__c, '物件データリアプロ(新規) 登録値確認：大型バイク置場料金税区分');
		System.assertEquals(pr_before.RentFeeSearch__c, pr.RentFeeSearch__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料');
		System.assertEquals(pr_before.RentFeeSearchManagement__c, pr.RentFeeSearchManagement__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費込');
		System.assertEquals(pr_before.RentFeeSearchParking__c, pr.RentFeeSearchParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料駐車場込');
		System.assertEquals(pr_before.RentFeeSearchManagementParking__c, pr.RentFeeSearchManagementParking__c, '物件データリアプロ(新規) 登録値確認：(検索用)賃料管理費駐車場込');
		System.assertEquals('居住中', pr.LiveStatus__c, '物件データ大東建託(掲載終了) 登録値確認：現況');
		System.assertEquals('しない', pr.WebPublishing__c, '物件データ大東建託(掲載終了) 登録値確認：web公開');
		System.assertEquals(false, pr.IsBulkConfirmation__c, '物件データリアプロ(新規) 登録値確認：一括確認チェック');
		System.assertEquals(null, pr.BulkConfirmationDate__c, '物件データリアプロ(新規) 登録値確認：一括確認日');
		System.assertEquals(CommonUtil.getNow().format('yyyy-MM-dd'), pr.OwnCompanyManageModDate__c.format('yyyy-MM-dd'), '物件データリアプロ(新規) 登録値確認：自社管理修正日');
		System.assertEquals(null, pr.TemporarySaveDate__c, '物件データリアプロ(新規) 登録値確認：一時保存日');
		System.assert(pr.AllRentFee__c == null, '物件データリアプロ(新規) 登録値確認：総賃料');
		System.assertEquals(true, pr.IsMergeCompletedFlag__c, '物件データリアプロ(新規) 登録値確認：名寄せ完了フラグ');
		System.assert(pr.Score__c == null, '物件データリアプロ(新規) 登録値確認：点数');
		System.assertEquals(DIFF_ROOMLAYOUT_FILE_NAME_INIT1, pr.AutoMaintenanceDiffRoomLayoutFileName__c, '物件データリアプロ(新規) 登録値確認：自動メンテナンス差分間取図ファイル名');
	}
	// ▲2022/5/31

	// ▼2022/6/6
	// テスト用自動リアプロ業者メンテナンス差分作成 大東建託連携
	private static Account SetAutoMaintenanceRealnetpro() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO; // 外部サイトコード
		String supplierName				= '自動メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−３';
		String supplierPostalCode		= null;	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−３';
		String supplierStreet			= null;
		String supplierPhone			= '051-726-3031';
		String supplierFax				= '051-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 花子';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

		return new Account(
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			ImportType__c					= importType,
			Name							= supplierName,
			PostalCode__c					= supplierPostalCode,
			Phone							= supplierPhone,
			Fax								= supplierFax,
			Representative__c				= supplierStaffName,
			RemarksPrivate__c				= supplierCompanyRemarks,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet
		);
	}

	// テスト用自動大東建託業者メンテナンス差分作成 大東建託連携
	private static Account SetAutoMaintenanceDaitoukentaku() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
        String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String supplierName				= '自動メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 花子';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

		return new Account(
			MaintenanceSupplierCode__c		= SUPPLIER_MAINT_CODE,
			ImportType__c					= importType,
			Name							= supplierName,
			PostalCode__c					= supplierPostalCode,
			Phone							= supplierPhone,
			Fax								= supplierFax,
			Representative__c				= supplierStaffName,
			RemarksPrivate__c				= supplierCompanyRemarks,
			State__c						= supplierState,
			City__c							= supplierCity,
			Street__c						= supplierStreet
		);
	}

	// テスト用自動リアプロ建物メンテナンス差分作成 大東建託連携
	private static Building__c SetBuildibgAutoMaintenanceRealnetpro() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;			// 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;		// 外部サイトコード
		String BuildingName				= '自動メンテ建物名';									// 建物名
		String BuildKana				= 'ｼﾞﾄﾞｳﾒﾝﾃﾀﾃﾓﾉﾒｲ';										// 建物名(カナ)
		String ChoazaCode				= '23456789012';										// 町字コード
		String State					= '大阪府';												// 都道府県
		String postalCode				= '234-5678';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '大阪市中央区１丁目';							// 住所１(市区町村)
		String Street					= '１２３−１';											// 住所２(番地)
		Decimal Latitude				= 35.169365;											// 緯度
		Decimal Longitude				= 137.002628;											// 経度
		String BuildingYM				= '200010';												// 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_SHAREHOUSE;				// 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_STEEL;						// 建物構造
		Decimal GroundFloorCount		= 50;													// 地上階数
		Decimal UndergroundFloorCount	= 1;													// 地下階数
		Decimal HouseCount				= 99;													// 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_PATROL;					// 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)確認';									// 建物備考(非公開)
		// 業者
		String supplierName				= 'リアプロメンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

		return new Building__c(
			Name							= BuildingName,
			BuildKana__c					= BuildKana,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			ImportType__c					= importType,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			ChoazaCode__c					= ChoazaCode,
			PostalCode__c					= postalCode,
			State__c						= State,
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingRemarksPrivate__c		= supplierRemarks
		);
	}

	// テスト用自動大東建託建物メンテナンス差分作成 大東建託連携
	private static Building__c SetBuildibgAutoMaintenanceDaitoukentaku() {
		String importType				= CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;       // 取込区分
		String externalSiteCd			= CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU; // 外部サイトコード
		String BuildingName				= '自動メンテ建物名';                                 // 建物名
		String BuildKana				= 'ｼﾞﾄﾞｳﾒﾝﾃﾀﾃﾓﾉﾒｲ';                                   // 建物名(カナ)
		String ChoazaCode				= '23456789012';                                      // 町字コード
		String State					= '大阪府';                                           // 都道府県
		String postalCode				= '234-5678';											// 郵便番号　2022/5/27 項目追加 大東建託連携
		String City						= '大阪市中央区１丁目';                         // 住所１(市区町村)
		String Street					= '１２３−１';                                        // 住所２(番地)
		Decimal Latitude				= 35.169365;                                          // 緯度
		Decimal Longitude				= 137.002628;                                         // 経度
		String BuildingYM				= '200010';                                           // 築年月
		String PropertyType				= AUTOMAINTEDIFF_PROPERTYTYPE_SHAREHOUSE;                // 物件種別
		String Structure				= AUTOMAINTEDIFF_STRUCTURE_STEEL;                    // 建物構造
		Decimal GroundFloorCount		= 50;                                                // 地上階数
		Decimal UndergroundFloorCount	= 1;                                                 // 地下階数
		Decimal HouseCount				= 99;                                               // 棟総戸数
		String CaretakerType			= AUTOMAINTEDIFF_CARETAKERTYPE_PATROL;                // 管理人種別
		String BuildingRemarksPrivate	= '建物備考(非公開)確認';                                 // 建物備考(非公開)
		// 業者
		String supplierName				= '大東建託メンテ業者';
		String supplierAccress			= '愛知県名古屋市名東区上社１丁目２１３−１';
		String supplierPostalCode		= '123-4567';	// 2022/5/27 管理会社郵便番号 追加 大東建託連携
		String supplierState			= '愛知県';
		String supplierCity				= '名古屋市名東区上社１丁目２１３−１';
		String supplierStreet			= null;
		String supplierPhone			= '052-726-3031';
		String supplierFax				= '052-726-3032';
		String supplierLicense			= '管理会社免許';
		String supplierStaffName		= '洞口 太郎';
		String supplierCompanyRemarks	= '管理会社備考';
		String supplierRemarks			= '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;  

		// 自動メンテナンス差分
		return new Building__c(
			Name							= BuildingName,
			BuildKana__c					= BuildKana,
			BuildingYM__c					= BuildingYM,
			PropertyType__c					= PropertyType,
			Structure__c					= Structure,
			GroundFloorCount__c				= GroundFloorCount,
			UndergroundFloorCount__c		= UndergroundFloorCount,
			HouseCount__c					= HouseCount,
			CaretakerType__c				= CaretakerType,
			ImportType__c					= importType,
			MaintenanceBuildingCode__c		= BUILDING_MAINT_CODE,
			ChoazaCode__c					= ChoazaCode,
			PostalCode__c					= postalCode,
			State__c						= State,
			City__c							= City,
			Street__c						= Street,
			Latitude__c						= Latitude,
			Longitude__c					= Longitude,
			BuildingRemarksPrivate__c		= supplierRemarks
		);
	}

	// テスト用自動リアプロ物件メンテナンス差分作成 大東建託連携
	private static Property__c SetPropertyAutoMaintenanceRealnetpro() {

		Building__c building = SetBuildibgAutoMaintenanceRealnetpro();
		insert building;

		BuildingCodeHistory__c buildingCodeHistory = new BuildingCodeHistory__c(
			Building__c = building.Id,
            HistoryMaintenanceBuildingCode__c = BUILDING_MAINT_CODE
		);
		insert buildingCodeHistory;

		String importType   = CommonConst.PROPERTY_IMPORTTYPE_REALNETPRO;		// 取込区分
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_REALNETPRO;	// 外部サイトコード
		String propertyName = '自動メンテ物件';								// 部屋番号
		Decimal floor = 10;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.46;												// 専有面積
		Decimal balconyArea = 978.66;											// バルコニー面積
		Decimal roomCount = 98;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2021';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '02';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）確認';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2022;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 11;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容確認';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)確認';						// 物件備考(非公開)
		Decimal rentFee = 2345678;												// 賃料
		Decimal managementFee = 234567;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 2222222;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 3333333;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 4444444;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 5555555;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 6666666;										// 更新料(円)
		Decimal keyExchangeFee = 777777;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 888888;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 999999;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 1111111;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 2222222;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 7;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 888888;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 222222;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 26;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 11;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考確認';						// 特優賃備考
		Decimal contractTermYear = 23;											// 契約期間（年）
		Decimal contractTermMonth = 11;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)確認';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 33333;												// 近隣駐車場までの距離
		Decimal parkingFee = 444444;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在確認';														// 鍵所在
		Decimal rewardBurdenLender = 5.55;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 6.66;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 7.77;										// 報酬配分元付
		Decimal rewardSplitCustomer = 8.88;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 222222222;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)確認';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '大阪府大阪市中央区１丁目１２３−１';
		String supplierState            = '大阪府';
		String supplierCity             = '大阪市名東中央区１丁目１２３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許確認';
		String supplierStaffName        = '洞口 花子';
		String supplierCompanyRemarks   = '管理会社備考確認';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

		return new Property__c(
			ImportType__c					= importType,
			Building__c						= building.Id,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			Name			                = propertyName,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_EXISTS,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			MonetaryPrivate__c      		= monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			ADRemarksPrivate__c             = ADRemarksPrivate,
			LiveStatus__c                   = liveStatus,
			WebPublishing__c				= webPublishing
		);
	}

	// テスト用自動大東建託物件メンテナンス差分作成 大東建託連携
	private static Property__c SetPropertyAutoMaintenanceDaitoukentaku() {

		Building__c building = SetBuildibgAutoMaintenanceDaitoukentaku();
		insert building;

		BuildingCodeHistory__c buildingCodeHistory = new BuildingCodeHistory__c(
			Building__c = building.Id,
            HistoryMaintenanceBuildingCode__c = BUILDING_MAINT_CODE
		);
		insert buildingCodeHistory;

		String importType   = CommonConst.PROPERTY_IMPORTTYPE_DAITOUKENTAKU;		// 取込区分
		String externalSiteCd = CommonConst.AUTOMAINTEDIFF_SITECODE_DAITOUKENTAKU;	// 外部サイトコード
		String propertyName = '自動メンテ物件';								// 部屋番号
		Decimal floor = 10;													// 所在階
		String balconyDirection = AUTOMAINTEDIFF_BALCONYDIRECTION_NORTH;		//  バルコニー方向
		Decimal roomArea = 123.46;												// 専有面積
		Decimal balconyArea = 978.66;											// バルコニー面積
		Decimal roomCount = 98;													// 部屋数
		String roomLayout = AUTOMAINTEDIFF_ROOMLAYOUT_R;						// 間取り
		String liveStatus = AUTOMAINTEDIFF_LIVESTATUS_RESIDENT;					// 現況
		String deliveryType = AUTOMAINTEDIFF_DELIVERYTYPE_DUEDATE;				// 引渡種別
		String deliveryYear = '2021';											// 引渡 年
		String deliveryMonth = AUTOMAINTEDIFF_DELIVERYMONTH_JAN; 				// 引渡 月
		String deliveryDay = '02';												// 引渡 日
		String deliveryTiming = null;											// 引渡 旬
		// ▼2022/5/27 項目追加 大東建託連携
		String deliveryConsultation = '引渡・入居日（相談内容）';					// 引渡・入居日(相談内容)
		Decimal renovationComplateYear = 2023;										// リノベ施工完了(年)
		Decimal renovationComplateMonth = 11;										// リノベ施工完了(月)
		String renovationContent = 'リノベ施工内容確認';								// リノベ施工内容 
		// ▲2022/5/27
		String propertyRemarksPrivate = '物件備考(非公開)確認';						// 物件備考(非公開)
		Decimal rentFee = 2345678;												// 賃料
		Decimal managementFee = 234567;											// 管理費
		String managementFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 管理費税区分
		String securityDepositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;				// 敷金単位
		Decimal securityDepositMonth = null;									// 敷金(ヶ月)
		Decimal securityDepositYen = 2222222;									// 敷金(円)
		String keyMoneyUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 礼金単位
		Decimal keyMoneyMonth = null;											// 礼金(ヶ月)
		Decimal keyMoneyYen = 3333333;											// 礼金(円)
		String depositUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 保証料金単位
		Decimal depositMonth = null;											// 保証料金(ヶ月)
		Decimal depositYen = 4444444;											// 保証料金(円)
		String cancellationActualFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;			// 敷引・償却単位
		Decimal cancellationActualFeeMonth = null;								// 敷引・償却(ヵ月)
		Decimal cancellationActualFeeRate = null;								// 敷引・償却(%)
		Decimal cancellationActualFeeYen = 5555555;								// 敷引・償却(円)
		Decimal renewalFeeMonth = null;											// 更新料(ヵ月)
		String renewalFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;						// 更新料単位
		String renewalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 更新料税区分
		Decimal renewalFeeYen = 6666666;										// 更新料(円)
		Decimal keyExchangeFee = 777777;										// 鍵交換費
		String keyExchangeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;			// 鍵交換費税区分
		Decimal wortFee = 888888;												// 水道料金
		String wortFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 水道料金税区分
		Decimal townshipFee = 999999;											// 町会費
		String townshipFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 町会費税区分
		String townshipFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_MONTH;		// 町会費支払区分
		Decimal CATVFee = 1111111;												// CATV
		String CATVTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// CATV税区分
		Decimal cleaningFeeYen = 2222222;										// 定額修繕費(円)
		Decimal cleaningFeeMonth = null;										// 定額修繕費(ヵ月)
		String cleaningFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;					// 定額修繕費単位
		String cleaningFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;				// 定額修繕費税区分
		String cleaningFeePaymentType = AUTOMAINTEDIFF_PAYMENTTYPE_BEFORE_OCCUPANCY;	// 定額修繕費支払区分
		String guaranteeidCompanyType = AUTOMAINTEDIFF_GUARANTEEIDCOMPANYTYPE_REQUIRED;	// 保証会社(利用区分)
		// ▼2022/5/27 項目追加 大東建託連携
		Decimal freeRentTermMonth = 7;											// フリーレント期間（ヶ月）
		String freeRentContent = 'フリーレント内容確認';							// フリーレント内容
		Decimal specificExcellentRentBurdenUpperLimit = 888888;					// 特優賃入居負担額上限
		Decimal specificExcellentRentBurdenLowerLimit = 222222;					// 特優賃入居負担額下限
		Decimal specificExcellentRentFeeUpwardRate = 26;						// 特優賃上昇率
		Decimal specificExcellentRentSupportYears = 11;							// 特優賃家賃補助年数
		String specificExcellentRentRemarks = '特優賃備考確認';						// 特優賃備考
		Decimal contractTermYear = 23;											// 契約期間（年）
		Decimal contractTermMonth = 11;											// 契約期間（月）
		// ▲2022/5/27
		String monetaryPrivate = '金銭備考(非公開)確認';									// 金銭備考(非公開)
		String parkingType = AUTOMAINTEDIFF_PARKINGTYPE_NEIGHBORHOOD_SECURE;			// 駐車場種別
		Decimal parkingDistance = 33333;												// 近隣駐車場までの距離
		Decimal parkingFee = 444444;													// 駐車場料金
		String parkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;						// 駐車場料金税区分
		String parkingRemarksPrivate = AUTOMAINTEDIFF_TAXTYPE_TAXABLE;					// 駐車場備考(非公開)
		String keyPlace = '鍵所在確認';														// 鍵所在
		Decimal rewardBurdenLender = 5.55;												// 報酬負担貸主
		Decimal rewardBurdenBorrower = 6.66;											// 報酬負担借主
		Decimal rewardSplitFormerSupplier = 7.77;										// 報酬配分元付
		Decimal rewardSplitCustomer = 8.88;												// 報酬配分客付
		// ▼2022/6/2 テストケース追加　大東建託連携
		String ADFeeUnit = AUTOMAINTEDIFF_FEEUNIT_YEN;									// 広告料単位
		Decimal ADFeeMonth = null;														// 広告料(ヵ月)
		Decimal ADFeeRate = null;														// 広告料(%)
		String ADFeeTaxType = AUTOMAINTEDIFF_ADVERTISINGTAXTYPE_TAXINCLUDED;			// 広告料税区分
		Decimal ADFeeYen = 222222222;													// 広告料(円)
		// ▲2022/6/2
		String ADRemarksPrivate = '広告備考(非公開)確認';									// 広告備考(非公開)
		// ▼2022/6/2 テストケース追加 大東建託連携
		String garbageDisposalFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// ごみ処理費税区分
		String townshipInitialFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 入町費税区分
		String bicycleParkingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐輪場代税区分
		String parkingDepositTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;				// 駐車場保証料金税区分
		String parkingCompoundingFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 駐車場手数料税区分
		String bikeParkingSmallFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 小型バイク置場料金税区分
		String bikeParkingMediumFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 中型バイク置場料金税区分
		String bikeParkinLargeFeeTaxType = AUTOMAINTEDIFF_TAXTYPE_NOTAXABLE;			// 大型バイク置場料金税区分
		// ▲2022/6/2
		String webPublishing = AUTOMAINTEDIFF_WEBPUBLISHING_NO;							// web公開　
		String supplierName             = '自動メンテ業者';
		String supplierAccress          = '大阪府大阪市名中央区１丁目１２３−１';
		String supplierState            = '大阪府';
		String supplierCity             = '大阪市東中央区１丁目１２３−１';
		String supplierStreet           = null;
		String supplierPhone            = '052-726-3031';
		String supplierFax              = '052-726-3032';
		String supplierLicense          = '管理会社免許確認';
		String supplierStaffName        = '洞口 花子';
		String supplierCompanyRemarks   = '管理会社備考確認';
		String supplierRemarks          = '';
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyLicense__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierLicense + CommonConst.BREAK_CODE;
		supplierRemarks += t_auto_maintenance_difference__c.ManagementCompanyRemarks__c.getDescribe().getlabel() + ':';
		supplierRemarks += supplierCompanyRemarks;

		return new Property__c(
			ImportType__c					= importType,
			Building__c						= building.Id,
			MaintenancePropertyCode__c      = PROPERTY_MAINT_CODE,
			Name			                = propertyName,
			Floor__c                        = floor,
			BalconyDirection__c             = balconyDirection,
			RoomArea__c                     = roomArea,
			BalconyArea__c                  = balconyArea,
			RoomCount__c                    = roomCount,
			RoomLayout__c                   = roomLayout,
			DeliveryType__c                 = deliveryType,
			DeliveryYear__c                 = deliveryYear,
			DeliveryMonth__c                = deliveryMonth,
			DeliveryDay__c                  = deliveryDay,
			DeliveryTiming__c               = deliveryTiming,
			BicycleParkingType__c			= AUTOMAINTEDIFF_BICYCLEPARKINGTYPE_EXISTS, // 2022/6/30 項目追加 大東建託連携
			BikeStorageType__c				= AUTOMAINTEDIFF_BIKEYARD_EXISTS,
			DeliveryConsultation__c			= deliveryConsultation,
			LivedType__c					= AUTOMAINTEDIFF_MOVEIN_EXISTS,
			RenovationComplateYear__c		= renovationComplateYear,
			RenovationComplateMonth__c		= renovationComplateMonth,
			RenovationContent__c			= renovationContent,
			PropertyRemarksPrivate__c       = propertyRemarksPrivate,
			RentFee__c                      = rentFee,
			ManagementFee__c                = managementFee,
			ManagementFeeTaxType__c         = managementFeeTaxType,
			SecurityDepositUnit__c          = securityDepositUnit,
			SecurityDepositMonth__c         = securityDepositMonth,
			SecurityDepositYen__c           = securityDepositYen,
			KeyMoneyUnit__c                 = keyMoneyUnit,
			KeyMoneyMonth__c                = keyMoneyMonth,
			KeyMoneyYen__c                  = keyMoneyYen,
			DepositUnit__c                  = depositUnit,
			DepositMonth__c                 = depositMonth,
			DepositYen__c                   = depositYen,
			CancellationActualFeeUnit__c    = cancellationActualFeeUnit,
			CancellationActualFeeMonth__c   = cancellationActualFeeMonth,
			CancellationActualFeeRate__c    = cancellationActualFeeRate,
			CancellationActualFeeYen__c     = cancellationActualFeeYen,
			RenewalFeeMonth__c              = renewalFeeMonth,
			RenewalFeeUnit__c               = renewalFeeUnit,
			RenewalFeeTaxType__c            = renewalFeeTaxType,
			RenewalFeeYen__c                = renewalFeeYen,
			KeyExchangeFee__c               = keyExchangeFee,
			KeyExchangeFeeTaxType__c        = keyExchangeFeeTaxType,
			WortFee__c                      = wortFee,
			WortFeeTaxType__c               = wortFeeTaxType,
			TownshipFee__c                  = townshipFee,
			TownshipFeeTaxType__c           = townshipFeeTaxType,
			TownshipFeePaymentType__c       = townshipFeePaymentType,
			CATVFee__c                      = CATVFee,
			CATVTaxType__c                  = CATVTaxType,
			CleaningFeeYen__c               = cleaningFeeYen,
			CleaningFeeMonth__c             = cleaningFeeMonth,
			CleaningFeeUnit__c              = cleaningFeeUnit,
			CleaningFeeTaxType__c           = cleaningFeeTaxType,
			CleaningFeePaymentType__c       = cleaningFeePaymentType,
			GuaranteeidCompanyType__c       = guaranteeidCompanyType,
			FreeRentTermMonth__c			= freeRentTermMonth,
			FreeRentContent__c				= freeRentContent,
			SpecificExcellentRentBurdenUpperLimit__c	= specificExcellentRentBurdenUpperLimit,
			SpecificExcellentRentBurdenLowerLimit__c	= specificExcellentRentBurdenLowerLimit,
			SpecificExcellentRentFeeFluctuationType__c	= AUTOMAINTEDIFF_SPECIALPREFERENTIALRENTFLUCTUATION_FLAT,
			SpecificExcellentRentFeeUpwardRate__c		= specificExcellentRentFeeUpwardRate,
			SpecificExcellentRentSupportYears__c		= specificExcellentRentSupportYears,
			SpecificExcellentRentRemarks__c				= specificExcellentRentRemarks,
			ContractTermYear__c							= contractTermYear,
			ContractTermMonth__c						= contractTermMonth,
			MonetaryPrivate__c		      	= monetaryPrivate,
			ParkingType__c                  = parkingType,
			ParkingDistance__c              = parkingDistance,
			ParkingFee__c                   = parkingFee,
			ParkingFeeTaxType__c            = parkingFeeTaxType,
			ParkingRemarksPrivate__c        = parkingRemarksPrivate,
			KeyPlace__c                     = keyPlace,
			RewardBurdenLender__c           = rewardBurdenLender,
			RewardBurdenBorrower__c         = rewardBurdenBorrower,
			RewardSplitFormerSupplier__c    = rewardSplitFormerSupplier,
			RewardSplitCustomer__c          = rewardSplitCustomer,
			ADFeeUnit__c					= ADFeeUnit,
			ADFeeMonth__c					= ADFeeMonth,
			ADFeeRate__c					= ADFeeRate,
			ADFeeTaxType__c					= ADFeeTaxType,
			ADFeeYen__c						= ADFeeYen,
			ADRemarksPrivate__c             = ADRemarksPrivate,
			LiveStatus__c                   = liveStatus,
			WebPublishing__c				= webPublishing
		);
	}
    // ▲2022/6/6 大東建託連携
}