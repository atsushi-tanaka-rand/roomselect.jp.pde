/**
* @File Name          : GD501001Controller.cls
* @Description        : ポータル掲載設定画面のコントローラ  // ▼ 2022.06.23 No.825 旧画面名のため現在の画面名に修正
**/
public with sharing class GD501001Controller {
    
    
    /** メッセージ系 */
    public String MSG_COM_V_SAVE {get {return CommonUtil.callMessageCreate(CommonConst.MSG_COM_V_SAVE);} private set;}        //js用保存確認メッセージ
    public String MSG_COM_I_SAVE {get {return CommonUtil.callMessageCreate(CommonConst.MSG_COM_I_SAVE);} private set;}        //js用保存完了メッセージ
    public String MSG_FINISH {get; set;} //js用特殊完了メッセージ
    
    /** ポータルサイト掲載方法の明細リスト */
    public List<screenPostingMeans> postingMeansRecordList { get; set; }

	// ▼ 2022.06.22 No.825 必要なグローバル項目の追加
	/** 登録設定ラジオボタン */
    public String registerType { get; set; }

    // 登録設定値
    public static String ALL_SETTING = '一括設定';
    public static String INDIVIUAL_SETTING = '個別設定';

	/** ポータル選択（リスト選択時） */
	public String portalSite {get; set;}     

	/** ポータル選択のリスト設定 */
	public list<SelectOption> setPortalSelectList { get; set; }  

	/** ポータルサイトの選択リスト値 */
    private final String SUUMO_STRING = CommonCONST.PORTALSITE_NAME_SUUMO; 
    private final String HOMES_STRING = CommonCONST.PORTALSITE_NAME_HOMES;
    private final String ATHOME_STRING = CommonCONST.PORTALSITE_NAME_AT_HOME;
	private final String CHINTAI_STRING = CommonCONST.PORTALSITE_NAME_CHINTAI;
	private final String PORTAL_STRING = CommonCONST.PORTALSITE_NAME_PORTAL;

	public String homesString{ get; set; }
    
    /** 地区リスト */
    public List<String>  districtStringList { get; private set; }
    private static List<String>  staticDistrictStringList;
    public List<Integer> districtIndexList { get; set;}
    
    /** 地区の選択リスト */
    public List<SelectOption> selectDistrictList { get; set; }
    
    /** ポータルサイト掲載地区の明細リスト */
    public List<screenPostingDistricts> postingDistrictsRecordList { get; set; }
    
    /** エラー関係 */
    public Boolean isOpenError { get; set; }
    public Boolean hasErrorMessage { get; set; }
    
    // チェックボックス変更状況
    public Boolean isChangeDistrict{get; set;}      //地区のチェックボックスが変更されたかどうか
    public Boolean isProcessing{get; set;}          //ガバナ制限対策により、処理中かどうか
    public Integer changeShopIndex {get; set;}      //変更された店舗index
    public Integer changeDistrictIndex {get; set;}  //変更された地区index
    
    // システム設定
    private SystemConfig__c  systemConfigData; //システム設定そのもの
    private Integer deleteLimit; //一度に削除できるレコード数(ガバナ対策)
    private Integer insertLimit; //一度に登録できるレコード数(ガバナ対策)
	public Boolean useAuthorityPortal {get; set;} //利用権限_自社HP // 2022.06.23 No.825 利用権限_自社HPの追加
    private SystemVariables__c portalProcessCheckboxDistrict;   // ポータル連携処理中チェックボックス_地区情報
    private SystemVariables__c portalProcessCheckboxShop;       // ポータル連携処理中チェックボックス_店舗情報
	private SystemVariables__c portalPostingDistrictSettingValue; // ポータル掲載設定_掲載地区設定値 // 2022.06.17 No.825 システム変数項目の追加

    /** 定数 */
    private static final String PORTALPROCESSCHECKBOX_DISTRICT = CommonConst.PORTALPROCESSCHECKBOX_DISTRICT; //システム変数　ポータル連携処理中チェックボックス_地区情報
    private static final String PORTALPROCESSCHECKBOX_SHOP = CommonConst.PORTALPROCESSCHECKBOX_SHOP;         //システム変数　ポータル連携処理中チェックボックス_店舗情報
    private static final String PORTAL_POSTING_DISTRICT_SETTING_VALUE = CommonConst.PORTAL_POSTING_DISTRICT_SETTING_VALUE; //システム変数 ポータル掲載設定_掲載地区設定値 // 2022.06.17 No.825 システム変数項目の追加

    
    
    public GD501001Controller() {
        try {
            //初期化
            init();
            
            //掲載方法明細List設定
            getScreenPostingMeansList();
            
            //掲載地区明細List設定
            getScreenPostingDistricsList();
            
            //チェックボックス変更状況設定
            setCheckBoxVariable();

            
        } catch (Exception e) {
            isOpenError = true; //エラーを設定
            CommonUtil.setErrorMessage(e);
        }
    }
    
    //============================================================以下publicメソッド=================================================================
    // @description 掲載方法登録処理
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/18
    // @return void
    public void registerPostingMeans(){
        
        Savepoint sp = Database.setSavepoint();  //セーブポイント作成
        
        try{
            hasErrorMessage = false;
            
            //掲載方法登録エラーチェック
            registerPostingMeansErrorCheck();
            
            //掲載方法更新処理
            postingMeansUpdate();
            
            //掲載方法明細List設定
            getScreenPostingMeansList();
            
            //掲載地区明細List設定
            staticDistrictStringList = new List<String>(districtStringList); //地区StringList再設定
            getScreenPostingDistricsList();
            
        }catch(Exception e) {
            Database.rollback(sp);//処理をロールバック
            hasErrorMessage = true;
            CommonUtil.setErrorMessage(e);
        }
    }
    
    
    // @description 掲載方法登録エラーチェック
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/18
    // @return void
    public void registerPostingMeansErrorCheck(){
        
        
        BusinessLogicException ex = new BusinessLogicException();
        
        for(integer i = 0; i < postingMeansRecordList.size(); i++) {
            
            //SUUMO物件名表示・非表示が両方trueの時
            if((postingMeansRecordList[i].isSuumoPropertyShow == true) && (postingMeansRecordList[i].isNotSuumoPropertyShow == true)) {
                ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_ANYONE));
            }
            //SUUMO物件名表示・非表示が両方falseの時
            else if((postingMeansRecordList[i].isSuumoPropertyShow == false) && (postingMeansRecordList[i].isNotSuumoPropertyShow == false)) {
                ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_CHOOSE));
            }
            //HOME'S物件名表示・非表示が両方trueの時
            if((postingMeansRecordList[i].isHomesPropertyShow == true) && (postingMeansRecordList[i].isNotHomesPropertyShow == true)) {
                ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_ANYONE));
            }
            //HOME'S物件名表示・非表示が両方falseの時
            else if((postingMeansRecordList[i].isHomesPropertyShow == false) && (postingMeansRecordList[i].isNotHomesPropertyShow == false)) {
                ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_CHOOSE));
            }
            //at home物件名表示・非表示が両方trueの時
            if((postingMeansRecordList[i].isAtHomePropertyShow == true) && (postingMeansRecordList[i].isNotAtHomePropertyShow == true)) {
                ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_ANYONE));
            }
            //at home物件名表示・非表示が両方falseの時
            else if((postingMeansRecordList[i].isAtHomePropertyShow == false) && (postingMeansRecordList[i].isNotAtHomePropertyShow == false)) {
                ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_CHOOSE));
            }

            // ▼ 2022.03.16 CHINTAI本対応 掲載方法登録エラーチェック処理を追加
			//CHINTAI物件名表示・非表示が両方trueの時
			if((postingMeansRecordList[i].isChintaiPropertyShow == true) && (postingMeansRecordList[i].isNotChintaiPropertyShow == true)) {
				ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_ANYONE));
			}
			//CHINTAI物件名表示・非表示が両方falseの時
			else if((postingMeansRecordList[i].isChintaiPropertyShow == false) && (postingMeansRecordList[i].isNotChintaiPropertyShow == false)) {
				ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_PROP_E_SELECTION_PORTALSITE_POSTING_CHOOSE));
			}
            // ▲ 2022.03.16 CHINTAI本対応
        }
        
        //ビジネスロジックException発行
        if(ex.hasMessage()) {
            throw ex;
        }
    }
    
    
    
    // @description 掲載方法更新処理
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/18
    // @return void
    public void postingMeansUpdate(){
        
        //更新用の掲載方法(店舗)リスト
        List<Shop__c> updatePostingMeansList = new List<Shop__c>();
        
        //掲載方法(店舗)の楽観ロックチェック
        Set<Id> postingMeansCheckedSet = new Set<Id>();
        Map<Id, Shop__c> postingMeansCheckedMap = new Map<Id, Shop__c>();
        
        for(screenPostingMeans s : postingMeansRecordList) {
            
            Boolean isAddPostingMeans = false; //掲載方法(店舗)更新フラグ
            
            //更新用の店舗
            Shop__c shopData = new Shop__c();
            
            //SUUMO物件名表示
            if((s.shopsRecord.IsSuumoPropertyShow__c == false) && (s.isSuumoPropertyShow == true)){
                isAddPostingMeans = true;
                shopData.IsSuumoPropertyShow__c = true;
            }
            //SUUMO非表示
            if((s.shopsRecord.IsSuumoPropertyShow__c == true) && (s.isNotSuumoPropertyShow == true)){
                isAddPostingMeans = true;
                shopData.IsSuumoPropertyShow__c = false;
            }
            //HOME'S物件名表示
            if((s.shopsRecord.IsHomesPropertyShow__c == false) && (s.isHomesPropertyShow == true)){
                isAddPostingMeans = true;
                shopData.IsHomesPropertyShow__c = true;
            }
            //HOME'S非表示
            if((s.shopsRecord.IsHomesPropertyShow__c == true) && (s.isNotHomesPropertyShow == true)){
                isAddPostingMeans = true;
                shopData.IsHomesPropertyShow__c = false;
            }
            //at home物件名表示
            if((s.shopsRecord.IsAtHomePropertyShow__c == false) && (s.isAtHomePropertyShow == true)){
                isAddPostingMeans = true;
                shopData.IsAtHomePropertyShow__c = true;
            }
            //at home非表示
            if((s.shopsRecord.IsAtHomePropertyShow__c == true) && (s.isNotAtHomePropertyShow == true)){
                isAddPostingMeans = true;
                shopData.IsAtHomePropertyShow__c = false;
            }
			
			// ▼ 2022.03.16 CHINTAI本対応 物件名更新処理を追加
			//CHINTAI物件名表示
			if((s.shopsRecord.IsChintaiPropertyShow__c == false) && (s.isChintaiPropertyShow == true)){
				isAddPostingMeans = true;
				shopData.IsChintaiPropertyShow__c = true;
			}
			//CHINTAI非表示
			if((s.shopsRecord.IsChintaiPropertyShow__c == true) && (s.isNotChintaiPropertyShow == true)){
				isAddPostingMeans = true;
				shopData.IsChintaiPropertyShow__c = false;
			}
            // ▲ 2022.03.16 CHINTAI本対応

            //更新フラグがtrueの時、更新用リストに対象の店舗データを追加
            if(isAddPostingMeans) {
                shopData.Id = s.shopsRecord.Id;
                updatePostingMeansList.add(shopData);
                postingMeansCheckedSet.add(s.shopsRecord.Id);
                postingMeansCheckedMap.put(s.shopsRecord.Id, s.shopsRecord);
            }
        }
        
        //更新用の掲載方法(店舗)リストが空でなければ、リストを更新(+ 楽観ロックチェック)
        if (!updatePostingMeansList.isEmpty()) {
            
            List<Shop__c> checkShopsData =[SELECT Id, SystemModstamp
                                           FROM Shop__c
                                           WHERE Id IN :postingMeansCheckedSet];
            
            for(Shop__c s: checkShopsData) {
                if(s.SystemModstamp != postingMeansCheckedMap.get(s.Id).SystemModstamp) {
                    OptimisticLockException ex = new OptimisticLockException();
                    throw ex;
                }
            }
            SecureDML.secureUpdate(updatePostingMeansList);
        }
    }
    
	// ▼ 2022.06.17 No.825 登録設定のラジオボタン追加
	/**
    * 登録設定ラジオボタン（VFオプション）
    * @param なし
    * @return List<SelectOption> ラジオボタンの選択値
    */
    public List<SelectOption> getIsregisterTypeRadioButton(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(GD501001Controller.ALL_SETTING, '一括設定'));
        options.add(new SelectOption(GD501001Controller.INDIVIUAL_SETTING, '個別設定'));
        return options;
    }
	// ▲ 2022.06.17 No.825 登録設定のラジオボタン追加

    
    
    // @description 掲載地区リスト取得
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/19
    // @return List<String>
    public void getDistrictStringList(){
        try{
            hasErrorMessage = false;
            
            //地区リストの初期化
            districtStringList = new List<String>();
            staticDistrictStringList = new List<String>();
            districtIndexList  = new List<Integer>();
            
            //地区の選択リスト値取得
            selectDistrictList = CommonUtil.getSelectOptionFromObject('grung__Building__c', 'grung__District__c', false);
            
            for(Integer i=0; i < selectDistrictList.size(); i++) {
                districtStringList.add(selectDistrictList[i].getValue());
                staticDistrictStringList.add(selectDistrictList[i].getValue());
                districtIndexList.add(i);
            }
            
        }catch(Exception e) {
            hasErrorMessage = true;
            CommonUtil.setErrorMessage(e);
            throw e;
        }
    }
   
    
    
    // @description 掲載地区登録処理
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/19
    // @return void
    public void registerPostingDistricts(){
        
        Savepoint sp = Database.setSavepoint();  //セーブポイント作成
        
        try{
            hasErrorMessage = false;
            
            //対象地区・店舗情報の宣言
            String  serchDistrict      = districtStringList[changeDistrictIndex];
            Integer serchDistrictIndex = changeDistrictIndex;
            Shop__c serchShop          = postingDistrictsrecordList[changeShopIndex].shopsRecordForDistrict;
            Integer serchShopIndex     = changeShopIndex;
            
			//対象のチェックボックスの値によって、登録or削除を実行
			// ▼ 2022.07.08 No.825 登録or削除条件を変更
            if(this.registerType == GD501001Controller.ALL_SETTING && !(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
                portalPropertyReset(serchDistrict, serchDistrictIndex, serchShop, serchShopIndex);  //ポータルサイト掲載物件初期化処理
            } else {
                portalPropertyUpdate(serchDistrict, serchDistrictIndex, serchShop, serchShopIndex); //ポータルサイト掲載物件登録処理	
            }
			// ▲ 2022.07.08 No.825 登録or削除条件を変更
            
            //掲載地区(店舗)更新処理
            postingDistrictsUpdate();
            
            //地区StringList再設定
            staticDistrictStringList = new List<String>(districtStringList);
            
            //掲載地区明細List設定
            getScreenPostingDistricsList();
            
            //掲載方法明細List設定
            getScreenPostingMeansList();

			// ▼ 2022.06.17 No.825 掲載地区設定値登録メソッドの追加
			//掲載地区設定値登録
			setPortalPostingDistrictSettingValue();
			// ▲ 2022.06.17 No.825 掲載地区設定値登録メソッドの追加
            
        }catch(Exception e) {
            Database.rollback(sp);//処理をロールバック
            hasErrorMessage = true;
            CommonUtil.setErrorMessage(e);
        }
    }
    
    
    
 
    
    
    
    // @description 掲載地区(店舗)更新処理
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/19
    // @return void
    public void postingDistrictsUpdate(){
        
        //更新用の掲載地区(店舗)リスト
        List<Shop__c> updatePostingDistrictsList = new List<Shop__c>();
        
        //掲載地区(店舗)の楽観ロックチェック
        Set<Id> postingDistrictsCheckedSet = new Set<Id>();
        Map<Id, Shop__c> postingDistrictsCheckedMap = new Map<Id, Shop__c>();
        
        for(screenPostingDistricts s : postingDistrictsRecordList) {
            
            Boolean isChange = false; //掲載地区(店舗)更新フラグ
            
            Shop__c updateShop = new Shop__c();
            
            for(integer i = 0; i < s.checkBoxList.size(); i++) {
                if(s.checkBoxList[i].check != s.oldCheckBoxList[i].check) {
                    isChange = true;
                    break;
                }
            }
            
            
            //更新フラグがtrueの場合
            if(isChange) {
                
                //対象店舗のIdを設定
                updateShop.Id = s.shopsRecordForDistrict.Id;

				// ▼ 2022.06.23 No.825 掲載地区登録条件及び利用権限_自社HPの追加
				this.useAuthorityPortal = Boolean.valueOf(SystemConfig__c.getInstance().UseAuthority_Portal__c); //利用権限_自社HP 

				if(this.registerType == GD501001Controller.ALL_SETTING){
                	//対象店舗のポータルサイト掲載地区に地区を追加
                	updateShop.PortalSitePostingDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';'); //ポータル掲載地区

					//各店舗のFTPアドレス（CHINTAIはWebAPIアドレス）の設定有無によって連携しているポータルサイトを判断
					if(String.isNotBlank(s.shopsRecordForDistrict.SuumoFtpServerAdress__c)){
						updateShop.PortalSitePostingSuumoDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';'); //ポータル掲載地区(SUUMO)
					}
					if(String.isNotBlank(s.shopsRecordForDistrict.HomesFtpServerAdress__c)){
						updateShop.PortalSitePostingHomesDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';'); //ポータル掲載地区(HOME'S)
					}
					if(String.isNotBlank(s.shopsRecordForDistrict.AtHomeFtpServerAdress__c)){
						updateShop.PortalSitePostingAtHomeDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';'); //ポータル掲載地区(at home)
					}
					if(String.isNotBlank(s.shopsRecordForDistrict.ChintaiWebApiAdress__c)){
						updateShop.PortalSitePostingChintaiDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';'); //ポータル掲載地区(CHINTAI)
					}
					if(this.useAuthorityPortal){
				 		updateShop.PortalSitePostingPortalDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';'); //ポータル掲載地区(自社ポータル)
					}
				}else{
					if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == SUUMO_STRING){
						//対象店舗のポータルサイト掲載地区(SUUMO)に地区を追加
						updateShop.PortalSitePostingSuumoDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
						s.shopsRecordForDistrict.PortalSitePostingSuumoDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
					}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == HOMES_STRING){
						//対象店舗のポータル掲載地区(HOME'S)に地区を追加
						updateShop.PortalSitePostingHomesDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
						s.shopsRecordForDistrict.PortalSitePostingHomesDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
					}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == ATHOME_STRING){
						//対象店舗のポータルサイト掲載地区(at home)に地区を追加
						updateShop.PortalSitePostingAtHomeDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
						s.shopsRecordForDistrict.PortalSitePostingAtHomeDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
					}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == CHINTAI_STRING){
						//対象店舗のポータルサイト掲載地区(CHINTA)に地区を追加
						updateShop.PortalSitePostingChintaiDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
						s.shopsRecordForDistrict.PortalSitePostingChintaiDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
					}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == PORTAL_STRING){
						//対象店舗のポータルサイト掲載地区(自社ポータル)に地区を追加
						updateShop.PortalSitePostingPortalDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
						s.shopsRecordForDistrict.PortalSitePostingPortalDistrict__c = String.join(getDistrictStringList(s.checkBoxList), ';');
					}
					//いずれかのポータルサイトでFTP連携を行っている場合
					if(String.isNotBlank(s.shopsRecordForDistrict.SuumoFtpServerAdress__c) 
					|| String.isNotBlank(s.shopsRecordForDistrict.HomesFtpServerAdress__c) 
					|| String.isNotBlank(s.shopsRecordForDistrict.AtHomeFtpServerAdress__c) 
					|| String.isNotBlank(s.shopsRecordForDistrict.ChintaiWebApiAdress__c) 
					|| this.useAuthorityPortal){
						List<String> updateList = new List<String>();
						//全地区の中から、連携されているポータルサイト全てで掲載されている地区を選別
						for(String districtString : districtStringList){
							//SUUMO FTPサーバアドレス=nullの場合またはポータル掲載地区(SUUMO)≠nullかつ対象地区と一致する場合
							if((String.isBlank(s.shopsRecordForDistrict.SuumoFtpServerAdress__c) 
							|| (String.isNotBlank(s.shopsRecordForDistrict.PortalSitePostingSuumoDistrict__c) 
							&& (s.shopsRecordForDistrict.PortalSitePostingSuumoDistrict__c.split(';').contains(districtString))))
							//HOME'S  FTPサーバアドレス=nullの場合またはポータル掲載地区(HOME'S)≠nullかつ対象地区と一致する場合
							&& (String.isBlank(s.shopsRecordForDistrict.HomesFtpServerAdress__c) 
							|| (String.isNotBlank(s.shopsRecordForDistrict.PortalSitePostingHomesDistrict__c) 
							&& (s.shopsRecordForDistrict.PortalSitePostingHomesDistrict__c.split(';').contains(districtString))))
							//at home FTPサーバアドレス=nullの場合またはポータル掲載地区(at home)≠nullかつ対象地区と一致する場合
							&& (String.isBlank(s.shopsRecordForDistrict.AtHomeFtpServerAdress__c) 
							|| (String.isNotBlank(s.shopsRecordForDistrict.PortalSitePostingAtHomeDistrict__c) 
							&& (s.shopsRecordForDistrict.PortalSitePostingAtHomeDistrict__c.split(';').contains(districtString))))
							//CHINTAI WEBAPIサーバアドレス=nullの場合またはポータル掲載地区(CHINTAI)≠nullかつ対象地区と一致する場合
							&& (String.isBlank(s.shopsRecordForDistrict.ChintaiWebApiAdress__c) 
							|| (String.isNotBlank(s.shopsRecordForDistrict.PortalSitePostingChintaiDistrict__c) 
							&& (s.shopsRecordForDistrict.PortalSitePostingChintaiDistrict__c.split(';').contains(districtString))))
							//利用権限_自社HP=falseの場合またはポータル掲載地区(自社ポータル)≠nullかつ対象地区と一致する場合
							&& (this.useAuthorityPortal == false 
							|| (String.isNotBlank(s.shopsRecordForDistrict.PortalSitePostingPortalDistrict__c) 
							&& (s.shopsRecordForDistrict.PortalSitePostingPortalDistrict__c.split(';').contains(districtString))))){
								updateList.add(districtString);	
							}
						}
						updateShop.PortalSitePostingDistrict__c = String.join(updateList, ';'); //ポータル掲載地区
					}
					
				}
				 // ▲ 2022.06.23 No.825 掲載地区登録条件の追加
                
                //更新用リストに対象の店舗データを追加
                updatePostingDistrictsList.add(updateShop);
                postingDistrictsCheckedSet.add(s.shopsRecordForDistrict.Id);
                postingDistrictsCheckedMap.put(s.shopsRecordForDistrict.Id, s.shopsRecordForDistrict);
            }
        }
        
        //更新用の掲載地区(店舗)リストが空でなければ、リストを更新(+ 楽観ロックチェック)
        if (!updatePostingDistrictsList.isEmpty()) {
            
            List<Shop__c> checkShopsData =[SELECT Id, SystemModstamp
                                           FROM Shop__c
                                           WHERE Id IN :postingDistrictsCheckedSet];
            
            for(Shop__c s: checkShopsData) {
                if(s.SystemModstamp != postingDistrictsCheckedMap.get(s.Id).SystemModstamp) {
                    OptimisticLockException ex = new OptimisticLockException();
                    throw ex;
                }
            }
            SecureDML.secureUpdate(updatePostingDistrictsList);
        }
    }
    
    
    
    // @description ポータルサイト掲載物件登録処理
    // @return void
    public void portalPropertyUpdate(String  serchDistrict , Integer serchDistrictIndex, Shop__c serchShop, Integer serchShopIndex){

        // ▼ 2022.07.11 No.825 登録更新継続フラグと登録対象リストの追加
		//登録更新継続フラグ
		Boolean continueFlg = false;
		//登録対象リスト
		List<PortalSitePostingProperty__c> targetPortalPropertyList = new List<PortalSitePostingProperty__c>();
        // ▲ 2022.07.11 No.825 登録更新継続フラグの追加
        
        //対象地区を使用して地区別メンテナンス条件から金額下限と金額上限を取得
        List<AreaMaintenanceCondition__c> areaMaintenanceCondition = [SELECT PropertyAmountLowerLimit__c//取扱い物件 金額(下限)
                                                                      ,PropertyAmountUpperLimit__c//取扱い物件 金額(上限)
                                                                      FROM AreaMaintenanceCondition__c
                                                                      WHERE District__c = :serchDistrict];
        
        //金額下限と金額上限の設定
        Decimal amountLowerLimit = null;
        Decimal amountUpperLimit = null;
        if ( !areaMaintenanceCondition.isEmpty() ) {
            amountLowerLimit = areaMaintenanceCondition[0].PropertyAmountLowerLimit__c;            /** 金額下限 */
            amountUpperLimit = areaMaintenanceCondition[0].PropertyAmountUpperLimit__c;            /** 金額上限 */
        }
        
        //queryに使用する変数宣言
        String PROPERTY_WEBPUBLISHING_EXISTS         = CommonConst.PROPERTY_WEBPUBLISHING_EXISTS;
        String PROPERTY_LIVESTATUS_SCHEDULEDTOLEAVE  = CommonConst.PROPERTY_LIVESTATUS_SCHEDULEDTOLEAVE;
        String PROPERTY_LIVESTATUS_VACANCY           = CommonConst.PROPERTY_LIVESTATUS_VACANCY;
        String searchShopId = serchShop.Id;
        
        //query作成
        String query = '';
        query +=    ' SELECT Id';
        query +=    '        ,FormerSupplier__r.SUUMO_press_ban__c';
        query +=    '        ,FormerSupplier__r.HOME_S_press_ban__c';
        query +=    '        ,FormerSupplier__r.at_home_press_ban__c';
		query +=    '        ,FormerSupplier__r.Chintai_press_ban__c'; // 2022.03.16 CHINTAI本対応 querry作成処理を追加
        query +=    '        ,FormerSupplier_Our_HP_press_ban__c';
        query +=    ' FROM Property__c';
        query +=    ' WHERE Building__r.District__c = :serchDistrict';
        query +=    ' AND WebPublishing__c = :PROPERTY_WEBPUBLISHING_EXISTS';
        query +=    ' AND (LiveStatus__c = :PROPERTY_LIVESTATUS_SCHEDULEDTOLEAVE  OR  LiveStatus__c = :PROPERTY_LIVESTATUS_VACANCY)';
        query +=    ' AND Id NOT IN (SELECT Property__c FROM PortalSitePostingProperty__c WHERE Shop__c = :searchShopId)';
        if (amountLowerLimit != null) {
            query+= ' AND RentFee__c >= :amountLowerLimit';
        }
        if (amountUpperLimit != null) {
            query+= ' AND RentFee__c <= :amountUpperLimit';
        }
        query +=    ' LIMIT ' + (insertLimit + 1);
        List<Property__c> targetPortalProperty = Database.query(query);

		// ▼ 2022.07.08 No.825 登録及び更新処理の追加
		//登録データ件数判定
		//登録データ件数が1000以下の場合
		if(targetPortalProperty.size() <= insertLimit){
			//ポータルサイト掲載物件更新処理
			continueFlg = updateProcess(serchDistrict,serchDistrictIndex,serchShop,serchShopIndex, targetPortalProperty.size());
		//それ以外の場合
		}else{
			//登録更新継続フラグ=true
			continueFlg = true;

			//リスト内の最後の１件削除
			targetPortalProperty.remove(insertLimit); //+1分を削除する
		}
			
		if(targetPortalProperty.size() > 0){

			//一括の場合（OFF⇒ON）
			if(this.registerType == GD501001Controller.ALL_SETTING && postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check) {
				//登録用リストに設定
				List<PortalSitePostingProperty__c> insertPortalPropertyList = new List<PortalSitePostingProperty__c>();
				for(Property__c p : targetPortalProperty) {
					insertPortalPropertyList.add(new PortalSitePostingProperty__c(
						Property__c       = p.Id
						, Shop__c         = serchShop.Id
						, IsSuumo__c      = !(p.FormerSupplier__r.SUUMO_press_ban__c)
						, IsHomes__c      = !(p.FormerSupplier__r.HOME_S_press_ban__c)
						, IsAtHome__c     = !(p.FormerSupplier__r.at_home_press_ban__c)
						, IsChintaiNet__c = !(p.FormerSupplier__r.Chintai_press_ban__c)
						, IsPortal__c     = !(p.FormerSupplier_Our_HP_press_ban__c)));
				}
				//登録対象リストに格納
				targetPortalPropertyList = insertPortalPropertyList;
			}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == SUUMO_STRING){
				//登録用リストに設定
				List<PortalSitePostingProperty__c> insertPortalPropertyList = new List<PortalSitePostingProperty__c>();
				for(Property__c p : targetPortalProperty) {
					insertPortalPropertyList.add(new PortalSitePostingProperty__c(
						Property__c       = p.Id
						, Shop__c         = serchShop.Id
						, IsSuumo__c      = !(p.FormerSupplier__r.SUUMO_press_ban__c)));
				}
				//登録対象リストに格納
				targetPortalPropertyList = insertPortalPropertyList;
			}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == HOMES_STRING){
				//登録用リストに設定
				List<PortalSitePostingProperty__c> insertPortalPropertyList = new List<PortalSitePostingProperty__c>();
				for(Property__c p : targetPortalProperty) {	
					insertPortalPropertyList.add(new PortalSitePostingProperty__c(
						Property__c       = p.Id
						, Shop__c         = serchShop.Id
						, IsHomes__c      = !(p.FormerSupplier__r.HOME_S_press_ban__c)));
				}
				//登録対象リストに格納
				targetPortalPropertyList = insertPortalPropertyList;
			}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == ATHOME_STRING){
				//登録用リストに設定
				List<PortalSitePostingProperty__c> insertPortalPropertyList = new List<PortalSitePostingProperty__c>();
				for(Property__c p : targetPortalProperty) {
					insertPortalPropertyList.add(new PortalSitePostingProperty__c(
						Property__c       = p.Id
						, Shop__c         = serchShop.Id
						, IsAtHome__c     = !(p.FormerSupplier__r.at_home_press_ban__c)));
				}
				//登録対象リストに格納
				targetPortalPropertyList = insertPortalPropertyList;
			}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == CHINTAI_STRING){
				//登録用リストに設定
				List<PortalSitePostingProperty__c> insertPortalPropertyList = new List<PortalSitePostingProperty__c>();
				for(Property__c p : targetPortalProperty) {					
					insertPortalPropertyList.add(new PortalSitePostingProperty__c(
						Property__c       = p.Id
						, Shop__c         = serchShop.Id
						, IsChintaiNet__c = !(p.FormerSupplier__r.Chintai_press_ban__c)));
				}
				//登録対象リストに格納
				targetPortalPropertyList = insertPortalPropertyList;
			}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == PORTAL_STRING){
				//登録用リストに設定
				List<PortalSitePostingProperty__c> insertPortalPropertyList = new List<PortalSitePostingProperty__c>();
				for(Property__c p : targetPortalProperty) {
					insertPortalPropertyList.add(new PortalSitePostingProperty__c(
						Property__c       = p.Id
						, Shop__c         = serchShop.Id
						, IsPortal__c     = !(p.FormerSupplier_Our_HP_press_ban__c)));
				}
				//登録対象リストに格納
				targetPortalPropertyList = insertPortalPropertyList;
			}
			//登録
			if(!targetPortalPropertyList.isEmpty()) {
				SecureDML.secureInsert(targetPortalPropertyList);
			}
		}
        // ▲ 2022.07.08 No.825 登録及び更新処理の追加
        
        //完了メッセージ設定
        // ▼ 2022.07.11 No.825 登録更新継続フラグの追加
		//登録更新継続フラグがtrueの場合
        if (continueFlg) {
			MSG_FINISH = CommonUtil.callMessageCreate(CommonConst.MSG_COM_I_PORTALINSERT, String.valueOf(insertLimit));
            postingDistrictsrecordList[serchShopIndex].checkBoxList[serchDistrictIndex].check = false; //チェックボックスをもとに戻す
            isChangeDistrict = false; //変更状態を解除する
            isProcessing     = true;  //継続処理を設定する
            updateSystemConfig(serchDistrict, serchShop.Name); //システム設定更新
        } else {
			MSG_FINISH = CommonUtil.callMessageCreate(CommonConst.MSG_COM_I_SAVE);
            isChangeDistrict = false; //変更状態を解除する
            isProcessing     = false; //継続処理を解除する
            updateSystemConfig(null, null); //システム設定更新
        }
        // ▲ 2022.07.11 No.825 登録更新継続フラグの追加
    }
    
	// ▼ 2022.07.08 No.825 ポータルサイト掲載物件更新処理メソッド追加
    /**
    * ポータルサイト掲載物件更新処理
    * @param String  serchDistrict 検索対象地区
	* @param Integer serchDistrictIndex 検索対象地区index
	* @param Shop__c serchShop 検索対象店舗情報
	* @param Integer serchShopIndex 検索対象店舗index
	* @param Integer insertSize 登録件数
    * @return Boolean 登録更新継続フラグ
    */
	public Boolean updateProcess(String serchDistrict, Integer serchDistrictIndex, Shop__c serchShop, Integer serchShopIndex, Integer insertSize){
		
		//更新限度(登録限度(1000)-登録件数)
		Integer updateLimit = insertLimit - insertSize;
		//登録更新継続フラグ
		Boolean continueFlg = false;

        //更新限度が0件の場合
        if(updateLimit == 0){
            continueFlg = true;
            return continueFlg;
        }

		//対象地区を使用して地区別メンテナンス条件から金額下限と金額上限を取得
        List<AreaMaintenanceCondition__c> areaMaintenanceCondition = [
			SELECT PropertyAmountLowerLimit__c//取扱い物件 金額(下限)
				  ,PropertyAmountUpperLimit__c//取扱い物件 金額(上限)
			FROM AreaMaintenanceCondition__c
			WHERE District__c = :serchDistrict];
        
        //金額下限と金額上限の設定
        Decimal amountLowerLimit = null;
        Decimal amountUpperLimit = null;
        if ( !areaMaintenanceCondition.isEmpty() ) {
            amountLowerLimit = areaMaintenanceCondition[0].PropertyAmountLowerLimit__c;            /** 金額下限 */
            amountUpperLimit = areaMaintenanceCondition[0].PropertyAmountUpperLimit__c;            /** 金額上限 */
        }
        
        //queryに使用する変数宣言
        String PROPERTY_WEBPUBLISHING_EXISTS         = CommonConst.PROPERTY_WEBPUBLISHING_EXISTS;
        String PROPERTY_LIVESTATUS_SCHEDULEDTOLEAVE  = CommonConst.PROPERTY_LIVESTATUS_SCHEDULEDTOLEAVE;
        String PROPERTY_LIVESTATUS_VACANCY           = CommonConst.PROPERTY_LIVESTATUS_VACANCY;
        String searchShopId = serchShop.Id;

		//更新対象データリスト
		List<PortalSitePostingProperty__c> targetUpdateList = new List<PortalSitePostingProperty__c>();

		//query作成
        String query = '';
        query +=    ' SELECT Id';
        query +=    '        ,Property__c';
        query +=    '        ,Shop__c';
        query +=    '        ,IsSuumo__c';
		query +=    '        ,IsHomes__c'; 
		query +=    '        ,IsAtHome__c';
        query +=    '        ,IsChintaiNet__c';
		query +=    '        ,IsPortal__c';
		query +=    '        ,Property__r.FormerSupplier_SUUMO_press_ban__c';
		query +=    '        ,Property__r.FormerSupplier_HOME_S_press_ban__c';
		query +=    '        ,Property__r.FormerSupplier_at_home_press_ban__c';
		query +=    '        ,Property__r.FormerSupplier_Chintai_press_ban__c';
		query +=    '        ,Property__r.FormerSupplier_Our_HP_press_ban__c';
        query +=    '        ,IsSuumoPanoramaPosting__c';
        query +=    ' FROM PortalSitePostingProperty__c';
		query +=    ' WHERE PropertyDistrict__c = :serchDistrict';
        query +=    ' AND Property__r.WebPublishing__c = :PROPERTY_WEBPUBLISHING_EXISTS';
        query +=    ' AND (Property__r.LiveStatus__c = :PROPERTY_LIVESTATUS_SCHEDULEDTOLEAVE  OR  Property__r.LiveStatus__c = :PROPERTY_LIVESTATUS_VACANCY)';
        if (amountLowerLimit != null) {
            query+= ' AND Property__r.RentFee__c >= :amountLowerLimit';
        }
        if (amountUpperLimit != null) {
            query+= ' AND Property__r.RentFee__c <= :amountUpperLimit';
        }
		//一括設定
        if(this.registerType == GD501001Controller.ALL_SETTING){
            query+= ' AND (IsSuumo__c = false';
			query+= ' OR IsHomes__c = false';
			query+= ' OR IsAtHome__c = false';
			query+= ' OR IsChintaiNet__c = false';
			query+= ' OR IsPortal__c = false)';
        }
		//個別設定かつポータルサイト=SUUMO
        if (this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == SUUMO_STRING){
			//チェックがON⇒OFF
			if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
				query+= ' AND IsSuumo__c = true';
			//チェックがOFF⇒ON
			}else{
				query+= ' AND IsSuumo__c = false';
			}
		}else if (this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == HOMES_STRING){
			//チェックがON⇒OFF
			if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
				query+= ' AND IsHomes__c = true';
			//チェックがOFF⇒ON
			}else{
				query+= ' AND IsHomes__c = false';
		}
		}else if (this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == ATHOME_STRING){
			//チェックがON⇒OFF
			if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
				query+= ' AND IsAtHome__c = true';
			//チェックがOFF⇒ON
			}else{
				query+= ' AND IsAtHome__c = false';
			}
		}else if (this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == CHINTAI_STRING){
			//チェックがON⇒OFF
			if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
				query+= ' AND IsChintaiNet__c = true';
			//チェックがOFF⇒ON
			}else{
				query+= ' AND IsChintaiNet__c = false';
			}
		}else if (this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == PORTAL_STRING){
			//チェックがON⇒OFF
			if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
				query+= ' AND IsPortal__c = true';
			//チェックがOFF⇒ON
			}else{
				query+= ' AND IsPortal__c = false';
			}
		}
        //Limit (更新限度+1)
        query +=    ' LIMIT ' + (updateLimit + 1);
        List<PortalSitePostingProperty__c> targetPortalPostingPropertyList = Database.query(query);
		
		//対象データが(更新限度+1)以上の場合
		if(targetPortalPostingPropertyList.size() >= updateLimit + 1){
			//最後のデータだけ削除
			targetPortalPostingPropertyList.remove(updateLimit);
			continueFlg = true;
		}

		//対象データが0件の場合
		if(targetPortalPostingPropertyList.isEmpty()){
			return continueFlg;
		}

		//一括設定かつOFF⇒ONの場合
		if(this.registerType == GD501001Controller.ALL_SETTING && (postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)){
			for(PortalSitePostingProperty__c targetPortalPostingProperty : targetPortalPostingPropertyList){
				//掲載情報を取得
				if(!(targetPortalPostingProperty.Property__r.FormerSupplier_SUUMO_press_ban__c)){
					targetPortalPostingProperty.IsSuumo__c = true;
				}
				if(!(targetPortalPostingProperty.Property__r.FormerSupplier_HOME_S_press_ban__c)){
					targetPortalPostingProperty.IsHomes__c = true;
				}
				if(!(targetPortalPostingProperty.Property__r.FormerSupplier_at_home_press_ban__c)){
					targetPortalPostingProperty.IsAtHome__c = true;
				}
				if(!(targetPortalPostingProperty.Property__r.FormerSupplier_Chintai_press_ban__c)){
					targetPortalPostingProperty.IsChintaiNet__c = true;
				}
				if(!(targetPortalPostingProperty.Property__r.FormerSupplier_Our_HP_press_ban__c)){
					targetPortalPostingProperty.IsPortal__c = true;
				}
				targetUpdateList.add(targetPortalPostingProperty);
			}
		//個別設定かつSUUMOの場合
		}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == SUUMO_STRING){
			for(PortalSitePostingProperty__c targetPortalPostingProperty : targetPortalPostingPropertyList){
				//チェックがON⇒OFF
				if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
					targetPortalPostingProperty.IsSuumo__c = false;
                    targetPortalPostingProperty.IsSuumoPanoramaPosting__c = false;
				//チェックがOFF⇒ON
				}else{
					if(!(targetPortalPostingProperty.Property__r.FormerSupplier_SUUMO_press_ban__c)){
						targetPortalPostingProperty.IsSuumo__c = true;
					}
				}
				targetUpdateList.add(targetPortalPostingProperty);
			}
		//個別設定かつHOME'Sの場合
		}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == HOMES_STRING){
			for(PortalSitePostingProperty__c targetPortalPostingProperty : targetPortalPostingPropertyList){
				//チェックがON⇒OFF
				if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
					targetPortalPostingProperty.IsHomes__c = false;
					targetPortalPostingProperty.IsHomesPanoramaPosting__c = false;
				//チェックがOFF⇒ON
				}else{
					if(!(targetPortalPostingProperty.Property__r.FormerSupplier_HOME_S_press_ban__c)){
						targetPortalPostingProperty.IsHomes__c = true;
					}
				}
				targetUpdateList.add(targetPortalPostingProperty);
			}
		//個別設定かつat homeの場合
		}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == ATHOME_STRING){
			for(PortalSitePostingProperty__c targetPortalPostingProperty : targetPortalPostingPropertyList){

				//チェックがON⇒OFF
				if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
					targetPortalPostingProperty.IsAtHome__c = false;
				//チェックがOFF⇒ON
				}else{
					if(!(targetPortalPostingProperty.Property__r.FormerSupplier_at_home_press_ban__c)){
						targetPortalPostingProperty.IsAtHome__c = true;
					}
				}
				targetUpdateList.add(targetPortalPostingProperty);
			}
		//個別設定かつCHINTAIの場合
		}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == CHINTAI_STRING){
			for(PortalSitePostingProperty__c targetPortalPostingProperty : targetPortalPostingPropertyList){
				//チェックがON⇒OFF
				if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
					targetPortalPostingProperty.IsChintaiNet__c = false;
					targetPortalPostingProperty.IsChintaiPanoramaPosting__c = false;
				//チェックがOFF⇒ON
				}else{
					if(!(targetPortalPostingProperty.Property__r.FormerSupplier_Chintai_press_ban__c)){
						targetPortalPostingProperty.IsChintaiNet__c = true;
					}
				}
				targetUpdateList.add(targetPortalPostingProperty);
			}
		//個別設定かつ自社ポータルの場合
		}else if(this.registerType == GD501001Controller.INDIVIUAL_SETTING && this.portalSite == PORTAL_STRING){
			for(PortalSitePostingProperty__c targetPortalPostingProperty : targetPortalPostingPropertyList){
				//チェックがON⇒OFF
				if(!(postingDistrictsrecordList[changeShopIndex].checkBoxList[changeDistrictIndex].check)) {
					targetPortalPostingProperty.IsPortal__c = false;
				//チェックがOFF⇒ON
				}else{
					if(!(targetPortalPostingProperty.Property__r.FormerSupplier_Our_HP_press_ban__c)){
						targetPortalPostingProperty.IsPortal__c = true;
					}
				}
				targetUpdateList.add(targetPortalPostingProperty);
			}
		}
		//更新
		SecureDML.secureUpdate(targetUpdateList);

		return continueFlg;
	}
	// ▼ 2022.07.08 No.826 ポータルサイト掲載物件更新処理メソッド追加
    
    
    
    // @description ポータルサイト掲載物件削除処理
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/19
    // @return void
    public void portalPropertyReset(String  serchDistrict, Integer serchDistrictIndex, Shop__c serchShop, Integer serchShopIndex){
        
        
        //削除対象のポータル掲載物件を取得
        List<PortalSitePostingProperty__c> targetPortalProperty = [SELECT Id FROM PortalSitePostingProperty__c
                                                                   WHERE Shop__c = :serchShop.Id
                                                                   AND PropertyDistrict__c IN (:serchDistrict)
                                                                   LIMIT :deleteLimit + 1 ];
        //完了メッセージ設定
        if (targetPortalProperty.size() <= deleteLimit) {
            
            MSG_FINISH = CommonUtil.callMessageCreate(CommonConst.MSG_COM_I_SAVE);
            isChangeDistrict = false; //変更状態を解除する
            isProcessing     = false; //継続処理を解除する
            updateSystemConfig(null, null); //システム設定更新
            
        } else {
            
            MSG_FINISH = CommonUtil.callMessageCreate(CommonConst.MSG_COM_I_PORTALDELETE, String.valueOf(deleteLimit));
            targetPortalProperty.remove(deleteLimit); //+1分を削除する
            postingDistrictsrecordList[serchShopIndex].checkBoxList[serchDistrictIndex].check = true; //チェックボックスをもとに戻す
            isChangeDistrict = false; //変更状態を解除する
            isProcessing     = true;  //継続処理を設定する
            updateSystemConfig(serchDistrict, serchShop.Name); //システム設定更新
            
        }
        
        //削除
        if(!targetPortalProperty.isEmpty()) {
            SecureDML.secureDelete(targetPortalProperty);
        }
        
    }
    
    
    //チェックボックス変更処理
    public void decideCheckbox() {
        
        //変更フラグ更新
        isChangeDistrict = !isChangeDistrict;
           
    }
    
    // ▼ 2022.06.22 No.825 掲載地区一覧呼び出しメソッドの追加
    /**
    * ポータルサイトごとの掲載地区一覧表呼び出し
    * @param なし
    * @return なし
    */
	public void callPortalPostingDistrictChart(){
		//地区StringList再設定
		staticDistrictStringList = new List<String>(districtStringList);

		//掲載地区明細List設定
		getScreenPostingDistricsList();
			
		//チェックボックス変更状況設定
		setCheckBoxVariable();
	}
	// ▼ 2022.06.22 No.825 掲載地区一覧呼び出しメソッドの追加

    
    
    
  
    
    
    
    
    //-----------------------------------------------------------------以下privateメソッド-----------------------------------------------------------------
    
    // @description 初期化メソッド
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/18
    // @return void
    private void init(){
        
            //初期化
            isOpenError = false;
            hasErrorMessage = false;
            // ▼ 2022.06.29 No.825 ビジネスロジックEx及び画面に連携するHOME'Sの文字列追加
			BusinessLogicException ex = new BusinessLogicException();

			//画面に連携するHOME'Sの文字列を設定
			this.homesString = CommonCONST.PORTALSITE_NAME_HOMES;
			// ▲ 2022.06.28 No.825 ビジネスロジックEx及び画面に連携するHOME'Sの文字列追加
            
            //システム設定 取得
            this.systemConfigData =  [ SELECT Id FROM SystemConfig__c ORDER BY CreatedDate Limit 1]; //組織のデフォルト値が1つある
            this.deleteLimit      = Integer.valueOf(SystemConfig__c.getInstance().PortalProcessNumForDelete__c);
            this.insertLimit      = Integer.valueOf(SystemConfig__c.getInstance().PortalProcessNumForInsert__c);
			this.useAuthorityPortal = Boolean.valueOf(SystemConfig__c.getInstance().UseAuthority_Portal__c); //利用権限_自社HP // 2022.06.23 No.825 利用権限_自社HPの追加
            
            //店舗異動が取得できなければエラー
            CommonUtil.getStaffCurrentShop();

			// ▼ 2022.06.17 No.825 掲載地区設定値取得及びラジオボタン/リストボックスの追加
			//掲載地区設定値取得
			SystemVariables__c districtSettingValue;
			
            //this.portalPostingDistrictSettingValue = [SELECT Id ,StringValue__c  FROM SystemVariables__c  WHERE VariablesName__c = :PORTAL_POSTING_DISTRICT_SETTING_VALUE ];
            List<SystemVariables__c> SettingValueList  = [SELECT Id ,StringValue__c  FROM SystemVariables__c  WHERE VariablesName__c = :PORTAL_POSTING_DISTRICT_SETTING_VALUE ];
			if(SettingValueList.isEmpty()){
				//ビジネスロジックException発行
				ex.addMessage(CommonUtil.callMessageCreate(CommonConst.MSG_COM_E_GET_SYSTEM_VARIABLES));
				throw ex;
			}else{
                this.portalPostingDistrictSettingValue = SettingValueList[0];
            }
        
			if(String.isBlank(this.portalPostingDistrictSettingValue.StringValue__c) || this.portalPostingDistrictSettingValue.StringValue__c != GD501001Controller.INDIVIUAL_SETTING){
				this.portalPostingDistrictSettingValue.StringValue__c = GD501001Controller.ALL_SETTING;
			}

			//必須のラジオボタン
            this.registerType = this.portalPostingDistrictSettingValue.StringValue__c;

			//ポータル選択の選択肢を作成・セット
            setPortalSelectList = new List<SelectOption>();
			
            setPortalSelectList.add(new SelectOption( SUUMO_STRING, 'SUUMO'));
			setPortalSelectList.add(new SelectOption( HOMES_STRING, 'HOME\'S'));
            setPortalSelectList.add(new SelectOption( ATHOME_STRING, 'at home'));
			setPortalSelectList.add(new SelectOption( CHINTAI_STRING, 'CHINTAI')); 
			setPortalSelectList.add(new SelectOption( PORTAL_STRING, '自社ポータル')); 

			//選択リスト値にSUUMOをセット
			this.portalSite = SUUMO_STRING;
			// ▲ 2022.06.17 No.825 掲載地区設定値取得及びラジオボタン/リストボックスの追加

			getDistrictStringList();
    }
    
    
    //チェックボックス変更状況設定
    private void setCheckBoxVariable(){

        //システム設定取得
        portalProcessCheckboxDistrict = [SELECT Id ,StringValue__c FROM SystemVariables__c  WHERE VariablesName__c = :PORTALPROCESSCHECKBOX_DISTRICT]; //処理中地区
        portalProcessCheckboxShop = [SELECT Id ,StringValue__c FROM SystemVariables__c  WHERE VariablesName__c = :PORTALPROCESSCHECKBOX_SHOP];     //処理中店舗

        
        //チェックボックス変更状況　初期化
        this.isChangeDistrict    = false; //地区のチェックボックスが変更されたかどうか
        this.isProcessing        = false; //ガバナ制限対策により、処理中かどうか
        this.changeShopIndex     = null;  //変更された店舗index
        this.changeDistrictIndex = null;  //変更された地区index
        
        //二つの変数が指し示すチェックボックスがあるか調査
        for(integer j = 0; j < postingDistrictsRecordList.size(); j++) {
            for(integer i = 0; i < postingDistrictsRecordList[j].checkBoxList.size(); i++) {
                
                //店舗と地区が システム設定の値と一致するなら
                if(postingDistrictsRecordList[j].shopsRecordForDistrict.Name == portalProcessCheckboxShop.StringValue__c &&
                   districtStringList[i] == portalProcessCheckboxDistrict.StringValue__c) {
                       //チェックボックス変更状況　設定
                       this.isChangeDistrict    = false; 
                       this.isProcessing        = true; 
                       this.changeShopIndex     = j;  
                       this.changeDistrictIndex = i;  
                       break;
                }
            }
            if(isProcessing) {
                break;
            }
        }
    }
    
    
    // @description 掲載方法明細List設定
    // @return void
    private void getScreenPostingMeansList(){
        try{
            hasErrorMessage = false;
            
            
            //内部クラスのリストを作成
            this.postingMeansRecordList = new List<screenPostingMeans>();
            
            //システム日付の取得
            Date getToday = CommonUtil.getToday();
            
            // データ取得SQL作成
            String sql = '';
            sql += 'SELECT Id';
            sql += '      ,Name';                       //店舗名
            sql += '      ,District__c';                //所在地区
            sql += '      ,IsSuumoPropertyShow__c';     //SUUMO物件名表示
            sql += '      ,IsHomesPropertyShow__c';     //HOME'S物件名表示
            sql += '      ,IsAtHomePropertyShow__c';    //at home物件名表示
			sql += '	  ,IsChintaiPropertyShow__c';   //CHINTAI物件名表示 // 2022.03.16 CHINTAI本対応 データ取得SQL作成に項目追加
            sql += '      ,SystemModstamp';             //SystemModstamp
            sql += '       FROM Shop__c';
            sql += '       WHERE (SystemUseStartDate__c <= :getToday ';
            sql += '            AND SystemUseEndDate__c   >= :getToday ';
            sql += '      	      )';
            sql += '       AND IsShopType__c    = TRUE ';
            sql += '       ORDER BY SortOrder__c';
            
            // データ取得
            List<Shop__c> shopsRecordList = Database.query(sql);
            
            
            //取得したデータの明細を回す
            for(shop__c s : shopsRecordList) {
                this.postingMeansRecordList.add(new screenPostingMeans(s));
            }
            
        }catch(Exception e) {
            hasErrorMessage = true;
            CommonUtil.setErrorMessage(e);
            throw e;
        }
    }
    
    
    
    // @description 掲載地区明細List設定
    // @author ChangeMeIn@UserSettingsUnder.SFDoc | 2020/2/19
    // @return void
    private void getScreenPostingDistricsList(){
        try{
            hasErrorMessage = false;
            
            
            //内部クラスのリストを作成
            this.postingDistrictsRecordList = new List<screenPostingDistricts>();
            
            //システム日付の取得
            Date getToday = CommonUtil.getToday();
            
            // データ取得SQL作成
            String sql = '';
            sql += 'SELECT Id';
            sql += '      ,Name';                       //店舗名
            sql += '      ,District__c';                //所在地区
			// ▼ 2022.06.21 No.825 ポータル掲載地区及びFTPサーバアドレス項目追加
			sql += '      ,PortalSitePostingDistrict__c'; //ポータル掲載地区
			sql += '      ,	PortalSitePostingSuumoDistrict__c'; //ポータル掲載地区(SUUMO)		
			sql += '      ,	PortalSitePostingHomesDistrict__c'; //ポータル掲載地区(HOME'S)	
			sql += '      ,	PortalSitePostingAtHomeDistrict__c'; //ポータル掲載地区(at home)
			sql += '      ,	PortalSitePostingChintaiDistrict__c'; //ポータル掲載地区(CHINTAI		
			sql += '      ,	PortalSitePostingPortalDistrict__c'; //ポータル掲載地区(自社ポータル)
			sql += '      ,	SuumoFtpServerAdress__c'; //SUUMO FTPサーバアドレス
			sql += '      ,	HomesFtpServerAdress__c'; //HOME'S FTPサーバアドレス
			sql += '      ,	AtHomeFtpServerAdress__c'; //at home FTPサーバアドレス
			sql += '      ,	ChintaiWebApiAdress__c'; //CHINTAI WEBAPIサーバアドレス
			// ▲ 2022.06.21 No.825 ポータル掲載地区及びFTPサーバアドレス項目追加
			sql += '      ,SystemModstamp';             //SystemModstamp
            sql += '       FROM Shop__c';
            sql += '       WHERE (SystemUseStartDate__c   <= :getToday ';
            sql += '            AND SystemUseEndDate__c   >= :getToday ';
            sql += '      	      )';
            sql += '       AND IsShopType__c    = TRUE ';
            sql += '       ORDER BY SortOrder__c';
            
            // データ取得
            List<Shop__c> portalRecordList = Database.query(sql);
            
            
            //取得したデータの明細を回す
            for(Shop__c s : portalRecordList) {
                this.postingDistrictsRecordList.add(new screenPostingDistricts(s,this.registerType,this.portalsite)); // ▼ 2022.06.28 No.825 ラジオボタン及びポータル選択ボタンの引数追加
            }
            
            
        }catch(Exception e) {
            hasErrorMessage = true;
            CommonUtil.setErrorMessage(e);
            throw e;
        }
    }
    
    
    // @description 明細地区List取得
    // @param List<Boolean> checkBoxList
    // @return List<String>
    private List<String> getDistrictStringList(List<checkBox> checkBoxList){
        
        List<String>  getDistrictStringList = new List<String>();
        
        for(integer i = 0; i < checkBoxList.size(); i++) {
            if(checkBoxList[i].check == true) {
                getDistrictStringList.add(districtStringList[i]);
            }
        }
        return getDistrictStringList;
    }
    
    
    //システム設定更新
    private void updateSystemConfig(String serchDistrict, String serchShop){
        this.portalProcessCheckboxDistrict.StringValue__c = serchDistrict;
        SecureDML.secureUpdate(portalProcessCheckboxDistrict);
        this.portalProcessCheckboxShop.StringValue__c     = serchShop;
        SecureDML.secureUpdate(portalProcessCheckboxShop);


    }

	// ▼ 2022.06.22 No.825 掲載地区設定値登録メソッドの追加
	/**
    * 登録設定ラジオボタン（VFオプション）
    * @param Id targetId システム変数「ポータル掲載設定_掲載地区設定値」のsfId
    * @return なし
    */
    private void setPortalPostingDistrictSettingValue(){
        try{
            hasErrorMessage = false;
			if(registerType == GD501001Controller.ALL_SETTING){
				this.portalPostingDistrictSettingValue.StringValue__c = GD501001Controller.ALL_SETTING;
			}if(registerType == GD501001Controller.INDIVIUAL_SETTING){
				this.portalPostingDistrictSettingValue.StringValue__c = GD501001Controller.INDIVIUAL_SETTING;
			}
			SecureDML.secureUpdate(this.portalPostingDistrictSettingValue);

        }catch(Exception e) {
            hasErrorMessage = true;
            CommonUtil.setErrorMessage(e);
            throw e;
        }
    }
	// ▲ 2022.06.22 No.825 掲載地区設定値登録メソッドの追加
    
    //↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓以下内部クラス↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    
    //掲載方法明細の内部クラス
    public class screenPostingMeans {
        
        //明細の店舗
        public Shop__c shopsRecord { get; set; }
        //SUUMO物件名表示
        public Boolean isSuumoPropertyShow { get; set; }
        //SUUMO非表示
        public Boolean isNotSuumoPropertyShow { get; set; }
        //HOME'S物件名表示
        public Boolean isHomesPropertyShow { get; set; }
        //HOME'S非表示
        public Boolean isNotHomesPropertyShow { get; set; }
        //at home物件名表示
        public Boolean isAtHomePropertyShow { get; set; }
        //at home非表示
        public Boolean isNotAtHomePropertyShow { get; set; }

		// ▼ 2022.03.16 CHINTAI本対応 内部クラスに項目を追加
		//CHINTAI物件名表示
		public Boolean isChintaiPropertyShow { get; set; }
		//CHINTAI非表示
		public Boolean isNotChintaiPropertyShow { get; set; }
		// ▲ 2022.03.16 CHINTAI本対応
        
        //コンストラクタ（引数：店舗）
        public screenPostingMeans(Shop__c targetShopsRecord){
            
            //物件名表示・非表示のチェックボックスを初期化
            isSuumoPropertyShow = false;
            isNotSuumoPropertyShow = false;
            isHomesPropertyShow = false;
            isNotHomesPropertyShow = false;
            isAtHomePropertyShow = false;
            isNotAtHomePropertyShow = false;

			// ▼ 2022.03.16 CHINTAI本対応 チェックボックス初期化処理に項目を追加
			isChintaiPropertyShow = false; 
			isNotChintaiPropertyShow = false;
			// ▲ 2022.03.16 CHINTAI本対応
            
            //変数の店舗に、引数の店舗を設定
            shopsRecord = targetShopsRecord;
            
            //物件名表示・非表示のチェックボックス化
            if(shopsRecord.IsSuumoPropertyShow__c == true) {
                //SUUMO(物件名表示)
                isSuumoPropertyShow = true;
                isNotSuumoPropertyShow = false;
            }else{
                //SUUMO(非表示)
                isSuumoPropertyShow = false;
                isNotSuumoPropertyShow = true;
            }
            
            if(shopsRecord.IsHomesPropertyShow__c == true) {
                //HOME'S(物件名表示)
                isHomesPropertyShow = true;
                isNotHomesPropertyShow = false;
            }else{
                //HOME'S(非表示)
                isHomesPropertyShow = false;
                isNotHomesPropertyShow = true;
            }
            
            if(shopsRecord.IsAtHomePropertyShow__c == true) {
                //at home(物件名表示)
                isAtHomePropertyShow = true;
                isNotAtHomePropertyShow = false;
            }else{
                //at home(非表示)
                isAtHomePropertyShow = false;
                isNotAtHomePropertyShow = true;
            }

			// ▼ 2022.03.16 CHINTAI本対応 物件名表示・非表示のチェックボックス化処理を追加
			if(shopsRecord.IsChintaiPropertyShow__c == true) {
				//CHINTAI(物件名表示)
				isChintaiPropertyShow = true;
				isNotChintaiPropertyShow = false;
			}else{
				//CHINTAI(非表示)
				isChintaiPropertyShow = false;
				isNotChintaiPropertyShow = true;
			}
			// ▲ 2022.03.16 CHINTAI本対応
        }
    }
    
    //掲載地区明細の内部クラス
    public class screenPostingDistricts {
        //明細の店舗
        public Shop__c shopsRecordForDistrict { get; set; }
        //【新】掲載地区リスト
        public List<checkBox> checkBoxList { get; set; }
        //【旧】掲載地区リスト
        public List<checkBox> oldCheckBoxList { get; set; }
        
        //コンストラクタ（引数：店舗）
        public screenPostingDistricts(Shop__c targetShopsRecordForDistrict, String registerType, String portalsite){ // 2022.06.28 No.825 ラジオボタン及びポータル選択ボタンの引数追加
            
            //変数の店舗に、引数の店舗を設定
            shopsRecordForDistrict = targetShopsRecordForDistrict;
            
            //【新】掲載地区リスト作成
            checkBoxList = new List<checkBox>();
            
            //【旧】掲載地区リスト作成
            oldCheckBoxList = new List<checkBox>();
            
            //地区の数だけチェックボックスを作成・初期化
            for(String s : staticDistrictStringList) {
                checkBoxList.add(new checkBox(false));
                oldCheckBoxList.add(new checkBox(false));
            }
            
            //店舗のポータルサイト掲載地区がnullでない場合、該当の地区にチェックをつける
			if(registerType == GD501001Controller.ALL_SETTING){ // 2022.06.22 No.825 一括設定条件追加
            	if(shopsRecordForDistrict.PortalSitePostingDistrict__c != null) {
					List<String> postingDistrictList = shopsRecordForDistrict.PortalSitePostingDistrict__c.split(';');
					for(integer i = 0; i < checkBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							checkBoxList[i].check = true;
						}
					} 
					for(integer i = 0; i < oldCheckBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							oldCheckBoxList[i].check = true;
						}
					}
				}
            // ▼ 2022.06.22 No.825 個別設定条件追加
			//店舗のポータルサイト掲載地区(SUUMO)がnullでない場合、該当の地区にチェックをつける
			}else if(registerType == GD501001Controller.INDIVIUAL_SETTING && portalSite == CommonCONST.PORTALSITE_NAME_SUUMO){
				if(shopsRecordForDistrict.PortalSitePostingSuumoDistrict__c != null) {
					List<String> postingDistrictList = shopsRecordForDistrict.PortalSitePostingSuumoDistrict__c.split(';');
					for(integer i = 0; i < checkBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							checkBoxList[i].check = true;
						}
					}
					for(integer i = 0; i < oldCheckBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							oldCheckBoxList[i].check = true;
						}
					}
				}
			//店舗のポータルサイト掲載地区(HOME'S)がnullでない場合、該当の地区にチェックをつける
			}else if(registerType == GD501001Controller.INDIVIUAL_SETTING && portalSite == CommonCONST.PORTALSITE_NAME_HOMES){
				if(shopsRecordForDistrict.PortalSitePostingHomesDistrict__c != null) {
					List<String> postingDistrictList = shopsRecordForDistrict.PortalSitePostingHomesDistrict__c.split(';');
					for(integer i = 0; i < checkBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							checkBoxList[i].check = true;
						}
					}
					for(integer i = 0; i < oldCheckBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							oldCheckBoxList[i].check = true;
						}
					}
				}
			//店舗のポータルサイト掲載地区(at home)がnullでない場合、該当の地区にチェックをつける
			}else if(registerType == GD501001Controller.INDIVIUAL_SETTING && portalSite == CommonCONST.PORTALSITE_NAME_AT_HOME){
				if(shopsRecordForDistrict.PortalSitePostingAtHomeDistrict__c != null) {
					List<String> postingDistrictList = shopsRecordForDistrict.PortalSitePostingAtHomeDistrict__c.split(';');
					for(integer i = 0; i < checkBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							checkBoxList[i].check = true;
						}
					}
					for(integer i = 0; i < oldCheckBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							oldCheckBoxList[i].check = true;
						}
					}
				}
			//店舗のポータルサイト掲載地区(CHINTAI)がnullでない場合、該当の地区にチェックをつける
			}else if(registerType == GD501001Controller.INDIVIUAL_SETTING && portalSite == CommonCONST.PORTALSITE_NAME_CHINTAI){
				if(shopsRecordForDistrict.PortalSitePostingChintaiDistrict__c != null) {
					List<String> postingDistrictList = shopsRecordForDistrict.PortalSitePostingChintaiDistrict__c.split(';');
					for(integer i = 0; i < checkBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							checkBoxList[i].check = true;
						}
					}
					for(integer i = 0; i < oldCheckBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							oldCheckBoxList[i].check = true;
						}
					}
				}
			//店舗のポータルサイト掲載地区(自社ポータル)がnullでない場合、該当の地区にチェックをつける
			}else if(registerType == GD501001Controller.INDIVIUAL_SETTING && portalSite == CommonCONST.PORTALSITE_NAME_PORTAL){
				if(shopsRecordForDistrict.PortalSitePostingPortalDistrict__c != null) {
					List<String> postingDistrictList = shopsRecordForDistrict.PortalSitePostingPortalDistrict__c.split(';');
					for(integer i = 0; i < checkBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							checkBoxList[i].check = true;
						}
					}
					for(integer i = 0; i < oldCheckBoxList.size(); i++) {
						if( postingDistrictList.contains(staticDistrictStringList[i]) ) {
							oldCheckBoxList[i].check = true;
						}
					}
				}
            } // ▲ 2022.06.22 No.825 個別設定条件追加
        }
    }
    
    //内部クラス　チェックボックス単体(List<Boolean>が使えないためやむなし)
    public class checkBox {
        public Boolean check {get; set;}
        
        public checkBox(Boolean check) {
            this.check = check;
        }
    }
    
}