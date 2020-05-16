class CDNItem{
  int _id;
  String _remark;
  String _url;

  CDNItem(this._id, this._remark, this._url);

  String getRemark(){
    return _remark;
  }
}