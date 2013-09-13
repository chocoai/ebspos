unit uModel;

interface
uses
  SynCommons,
  mORMot;

type
  TGender = (gUnknow, gMale, gFemale);
  //�ŵ��ڵ�Ա����¼
  TSQLAccount = class(TSQLRecord)
  private
    //f_usr_no           : RawUTF8;
    f_account_name         : RawUTF8;
    f_pwd              : RawUTF8;
    //f_dep_no           : Integer;
    f_age              : Integer;
    f_gender           : TGender;
    f_edu_bg           : RawUTF8;
    f_birthday         : TTimeLog;
    f_entry_date       : TTimeLog;
    //f_id_card_no       : RawUTF8;
    //f_fax_no           : RawUTF8;
    f_phone_no         : RawUTF8;
    f_address          : RawUTF8;
    //f_position         : RawUTF8;
    f_salary           : Currency;
    f_email            : RawUTF8;
    f_royalty_rate     : Currency;
    //f_remarks          : RawUTF8;      //��ע
    //f_is_use           : Boolean;
    //f_usr_type         : RawUTF8;
    //f_upd_time         : TTimeLog;
    //f_crd_time         : TTimeLog;     
    //f_upd_usr          : RawUTF8;      //������
    //f_crd_usr          : RawUTF8;      //������
    f_inservice          : Boolean;
    function get_age: Integer;
  published
    //property usr_no           : RawUTF8    read f_usr_no       write f_usr_no;      
    property account_name         : RawUTF8    read f_account_name     write f_account_name;
    property pwd              : RawUTF8    read f_pwd          write f_pwd;         
    //property dep_no           : Integer    read f_dep_no       write f_dep_no;      
    property age              : Integer    read get_age;         
    property gender           : TGender    read f_gender       write f_gender;      
    property edu_bg           : RawUTF8    read f_edu_bg       write f_edu_bg;      
    property birthday         : TTimeLog   read f_birthday     write f_birthday;    
    property entry_date       : TTimeLog   read f_entry_date   write f_entry_date;  
    //property id_card_no       : RawUTF8    read f_id_card_no   write f_id_card_no;  
    //property fax_no           : RawUTF8    read f_fax_no       write f_fax_no;      
    property phone_no         : RawUTF8    read f_phone_no     write f_phone_no;    
    property address          : RawUTF8    read f_address      write f_address;     
    //property position         : RawUTF8    read f_position     write f_position;    
    property salary           : Currency   read f_salary       write f_salary;      
    property email            : RawUTF8    read f_email        write f_email;       
    property royalty_rate     : Currency   read f_royalty_rate write f_royalty_rate;
    //property remarks          : RawUTF8    read f_remarks      write f_remarks;     //��ע
    //property is_use           : Boolean    read f_is_use       write f_is_use;      
    //property usr_type         : RawUTF8    read f_usr_type     write f_usr_type;    
    //property upd_time         : TTimeLog   read f_upd_time     write f_upd_time;    
    //property crd_time         : TTimeLog   read f_crd_time     write f_crd_time;    
    //property upd_usr          : RawUTF8    read f_upd_usr      write f_upd_usr;    //������
    //property crd_usr          : RawUTF8    read f_crd_usr      write f_crd_usr;    //������
    property inservice          : Boolean    read f_inservice    write f_inservice;  //�Ƿ���ְ
  end;
  
  TStoreSize = (
    ssOne,        //һ�˵�
    ssCouple,     //���޵�
    ssSmall,      //3~10��
    ssMiddle,     //10����100������
    ssLarge,      //100������1000������
    ssHuge       //1000������
  );
  
  //�ŵ��¼��ֻ��һ����
  TSQLStore = class(TSQLRecord)
  private
    f_store_name     : RawUTF8;
    f_address        : RawUTF8;
    f_phone          : RawUTF8;
    f_email          : RawUTF8;
    f_size           : TStoreSize;
  published
    property store_name     : RawUTF8 read f_store_name write f_store_name;
    property address        : RawUTF8 read f_address write f_address;
    property phone          : RawUTF8 read f_phone write f_phone;
    property email          : RawUTF8 read f_email write f_email;
    property size           : TStoreSize read f_size write f_size;
  end;
  
  TSQLConceptType = class(TSQLRecord)
  private
    f_goods_type_name: RawUTF8;
    f_info: RawUTF8;
    f_parent: TSQLConceptType;
    f_pinyin_code: RawUTF8; //ƴ������
    f_level: Integer; //����
    f_path: RawUTF8;  //ȫ·��
    f_func: RawUTF8; //�������
  published
    property goods_type_name: RawUTF8 read f_goods_type_name write f_goods_type_name;
    property info: RawUTF8 read f_info write f_info;
    property parent: TSQLConceptType read f_parent write f_parent;
    property pinyin_code: RawUTF8 read f_pinyin_code write f_pinyin_code; //ƴ������
    property level: Integer read f_level write f_level; //����
    property path: RawUTF8 read f_path write f_path;  //ȫ·��
    property func: RawUTF8 read f_func write f_func; //�������
  end;
  
  TSeason = (sSpring, sSummer, sAutumn, sWinter);
  
  //��Ʒ��������
  TSQLGoods = class(TSQLRecord)
  private
    f_goods_code: RawUTF8;
    f_goods_name: RawUTF8;
    f_goods_type: TSQLConceptType;
    f_sub_goods_type: TSQLConceptType;
    f_small_goods_type: TSQLConceptType;
    f_brand: RawUTF8;
    f_produce_area: RawUTF8;
    f_produce_name: RawUTF8;
    f_color: RawUTF8;
    f_bar_code: RawUTF8;
    f_model: RawUTF8;  //���
    f_base_unit: RawUTF8;
    f_buy_ref_price: Currency; //�ο�����
    f_sell_ref_price: Currency; //�ο�����
    f_cost_price: Currency; //�ɱ���
    f_picture: TSQLRawBlob; //ͼƬ
    f_stop_flag: Boolean; //�Ƿ�ͣ��
    f_info: RawUTF8; //ע��
    f_season: TSeason; //����
    f_year: TTimeLog; //���
  published
    property goods_code: RawUTF8 read f_goods_code write f_goods_code;
    property goods_name:RawUTF8 read f_goods_name write f_goods_name;
    property goods_type: TSQLConceptType read f_goods_type write f_goods_type;
    property sub_goods_type: TSQLConceptType read f_sub_goods_type write f_sub_goods_type;
    property small_goods_type: TSQLConceptType read f_small_goods_type write f_small_goods_type;
    property brand: RawUTF8 read f_brand write f_brand;
    property produce_area: RawUTF8 read f_produce_area write f_produce_area;
    property produce_name: RawUTF8 read f_produce_name write f_produce_name;
    property color: RawUTF8 read f_color write f_color;
    property bar_code: RawUTF8 read f_bar_code write f_bar_code;
    property model: RawUTF8 read f_model write f_model;  //���
    property base_unit: RawUTF8 read f_base_unit write f_base_unit;
    property buy_ref_price: Currency read f_buy_ref_price write f_buy_ref_price; //�ο�����
    property sell_ref_price: Currency read f_sell_ref_price write f_sell_ref_price; //�ο�����
    property cost_price: Currency read f_cost_price write f_cost_price; //�ɱ���
    property picture: TSQLRawBlob read f_picture write f_picture; //ͼƬ
    property stop_flag: Boolean read f_stop_flag write f_stop_flag; //�Ƿ�ͣ��
    property info: RawUTF8 read f_info write f_info; //ע��
    property season: TSeason read f_season write f_season; //����
    property year: TTimeLog read f_year write f_year; //���
  end;
  
  //Ȩ����صı�
  
  //��ɫ��
  TSQLRole = class(TSQLRecord)
  private
    f_role_name    : RawUTF8;
    f_info         : RawUTF8;
  published
    property role_name: RawUTF8 read f_role_name write f_role_name;
    property info: RawUTF8 read f_info write f_info;
  public
    function IsAdmin: Boolean;
  end;
  
  TActionRight = (arNone, arEnabled, arVisible);
  
  //��ɫȨ�ޱ�
  TSQLRoleActionMap = class(TSQLRecord)
  private
    f_role: TSQLRole;
    f_action: RawUTF8;
    f_right: TActionRight;
  published
    property role: TSQLRole read f_role write f_role;
    property action: RawUTF8 read f_action write f_action;
    property right: TActionRight read f_right write f_right;
  end;
  
  //�û���ɫ��
  TSQLAccountRoleMap = class(TSQLRecord)
  private
    f_account: TSQLAccount;
    f_role: TSQLRole;
  published
    property account: TSQLAccount read f_account write f_account;
    property role: TSQLRole read f_role write f_role;
  end;
  
  TSQLLoginRecords = class(TSQLRecord)
  private
    f_account_id : Integer;
    f_login_time : TTimeLog;
  end;
  
  function CreateModel: TSQLModel;
  
  resourcestring
    sAdminRoleName = '����Ա';
    sAdminRoleInfo = '����Ա��ӵ��ϵͳ����Ȩ��';
  
implementation
uses
  uSingleton, uValidator, DateUtils, SysUtils;



function CreateModel: TSQLModel;
var
  passwordValidator: TSynValidatePassword;
begin
  //add validator
  TSQLStore.AddFilterOrValidate('store_name', TPkValidateNotEmpty.Create);
  TSQLStore.AddFilterOrValidate('address', TPkValidateNotEmpty.Create);
  TSQLStore.AddFilterOrValidate('phone', TPkValidateNotEmpty.Create);
  TSQLStore.AddFilterOrValidate('email', TPkValidateNotEmpty.Create);
  TSQLStore.AddFilterOrValidate('email', TSynValidateEmail.Create);
  TSQLStore.AddFilterOrValidate('store_size', TPkValidateNotEmpty.Create);
  
  TSQLAccount.AddFilterOrValidate('account_name', TPkValidateNotEmpty.Create);
  TSQLAccount.AddFilterOrValidate('account_name', TSynValidateUniqueField.Create);
  TSQLAccount.AddFilterOrValidate('pwd', TPkValidateNotEmpty.Create);
  passwordValidator := TSynValidatePassword.Create;
  with passwordValidator do
  begin
    MinLength := 6;
    MaxLength := 10;
    MinAlphaCount := 1;
    MinDigitCount := 1;
    MinPunctCount := 0;
    MinLowerCount := 1;
    MinUpperCount := 1;
    MaxSpaceCount := 0;
  end;
  TSQLAccount.AddFilterOrValidate('pwd', passwordValidator);
  
  TSQLRole.AddFilterOrValidate('role_name', TSynValidateUniqueField.Create);
  
  TSQLConceptType.AddFilterOrValidate('goods_type_name', TSynValidateUniqueField.Create);
  
  TSQLGoods.AddFilterOrValidate('goods_code', TSynValidateUniqueField.Create);
  TSQLGoods.AddFilterOrValidate('gooods_name', TPkValidateNotEmpty.Create);
  
  result := TSQLModel.Create([TSQLAccount, TSQLStore, TSQLConceptType, TSQLGoods, TSQLRole, TSQLAccountRoleMap, TSQLRoleActionMap]);
end;

function TSQLRole.IsAdmin: Boolean;
begin
  result := role_name = sAdminRoleName;
end;


function TSQLAccount.get_age: Integer;
var
  birthDate: TDateTime;
begin
  birthDate := Iso8601(birthday).ToDate;
  Result := YearsBetween(Now, birthDate);
end;


end.
