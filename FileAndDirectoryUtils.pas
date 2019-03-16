unit FileAndDirectoryUtils;

interface

uses
  Generics.Collections,
  System.IOUtils,
  System.SysUtils,
  System.RegularExpressions;

type

  TDirectoryEntryType = ( detFiles, detDirectories, detAll );

  //====================================================================================================================
  // class __TDirectoryEntryList =======================================================================================
  //====================================================================================================================
  __TDirectoryEntryList = class(TList<String>)

    type
      TResultFormat =         ( rfNames, rfPaths);

    private
      Directory:              String;
      DirectoryEntryType:     TDirectoryEntryType;
      FileMask:               String;
      RegularExpression:      String;
      ResultFormat:           TResultFormat;

      SearchPath:             String;
      UseRegularExpression:   Boolean;
      SearchAttr:             Integer;

      procedure GetDirectoryEntries();
    public
      constructor Create(Directory: String;
                         DirectoryEntryType: TDirectoryEntryType;
                         FileMask: String;
                         RegularExpression: String;
                         ResultFormat: TResultFormat);

  end;

  //====================================================================================================================
  // class TFileNameList ===============================================================================================
  //====================================================================================================================
  TFileNameList = class(__TDirectoryEntryList)
    public
      constructor Create(Directory: String; FileMask: String; RegularExpression: String);
  end;


  //====================================================================================================================
  // class TFilePathList ===============================================================================================
  //====================================================================================================================
  TFilePathList = class(__TDirectoryEntryList)
    public
      constructor Create(Directory: String; FileMask: String; RegularExpression: String);
  end;


  //====================================================================================================================
  // class TDirectoryNameList ==========================================================================================
  //====================================================================================================================
  TDirectoryNameList = class(__TDirectoryEntryList)
    public
      constructor Create(Directory: String; DirectoryMask: String; RegularExpression: String);
  end;


  //====================================================================================================================
  // class TDirectoryPathList ==========================================================================================
  //====================================================================================================================
  TDirectoryPathList = class(__TDirectoryEntryList)
    public
      constructor Create(Directory: String; DirectoryMask: String; RegularExpression: String);
  end;


  //====================================================================================================================
  // class TFileAndDirectoryNameList ===================================================================================
  //====================================================================================================================
  TFileAndDirectoryNameList = class(__TDirectoryEntryList)
    public
      constructor Create(Directory: String; DirectoryMask: String; RegularExpression: String);
  end;


  //====================================================================================================================
  // class TFileAndDirectoryPathList ===================================================================================
  //====================================================================================================================
  TFileAndDirectoryPathList = class(__TDirectoryEntryList)
    public
      constructor Create(Directory: String; DirectoryMask: String; RegularExpression: String);
  end;


implementation


//======================================================================================================================
// class __TDirectoryEntryList =========================================================================================
//======================================================================================================================
constructor __TDirectoryEntryList.Create(Directory: String;
                                         DirectoryEntryType: TDirectoryEntryType;
                                         FileMask: String;
                                         RegularExpression: String;
                                         ResultFormat: TResultFormat);
begin
  inherited Create;
  self.Directory := Directory;
  self.DirectoryEntryType := DirectoryEntryType;
  self.Filemask := FileMask;
  self.RegularExpression := RegularExpression;
  self.ResultFormat := ResultFormat;

  SearchPath := System.IOUtils.TPath.Combine(Directory, FileMask);
  UseRegularExpression := RegularExpression <> '';

  GetDirectoryEntries();
end;

//======================================================================================================================
procedure __TDirectoryEntryList.GetDirectoryEntries();
var
  SearchResult: TSearchRec;
  ValidEntry:   Boolean;
begin

  if findfirst(SearchPath, faAnyFile, SearchResult) = 0 then
  begin
    repeat
      case DirectoryEntryType of
        detFiles:
          ValidEntry := SearchResult.Attr = (SearchResult.Attr and (faReadOnly + faHidden + faSysFile + faArchive));
        detDirectories:
          ValidEntry := SearchResult.Attr = (SearchResult.Attr and faDirectory);
        detAll:
          ValidEntry := (SearchResult.Attr = (SearchResult.Attr and faDirectory)) or
                        (SearchResult.Attr = SearchResult.Attr and (faReadOnly + faHidden + faSysFile + faArchive))
      end;
      if ValidEntry then begin

        if UseRegularExpression then
          ValidEntry := TRegEx.IsMatch(SearchResult.Name, RegularExpression);

        if ValidEntry then begin
            if ResultFormat = rfNames then
              self.Add(SearchResult.Name)
            else
              self.Add(System.IOUtils.TPath.Combine(Directory, SearchResult.Name));
        end;
      end;

    until FindNext(SearchResult) <> 0;
    FindClose(SearchResult);
  end;
end;


//======================================================================================================================
// class TFileNameList =================================================================================================
//======================================================================================================================
constructor TFileNameList.Create(Directory: String; FileMask: String; RegularExpression: String);
begin
  inherited Create(Directory, detFiles, FileMask, RegularExpression, rfNames);
end;


//======================================================================================================================
// class TFilePathList =================================================================================================
//======================================================================================================================
constructor TFilePathList.Create(Directory: String; FileMask: String; RegularExpression: String);
begin
  inherited Create(Directory, detFiles, FileMask, RegularExpression, rfPaths);
end;


//======================================================================================================================
// class TDirectoryNameList ============================================================================================
//======================================================================================================================
constructor TDirectoryNameList.Create(Directory: String; DirectoryMask: String; RegularExpression: String);
begin
  inherited Create(Directory, detDirectories, DirectoryMask, RegularExpression, rfNames);
end;


//======================================================================================================================
// class TDirectoryPathList ============================================================================================
//======================================================================================================================
constructor TDirectoryPathList.Create(Directory: String; DirectoryMask: String; RegularExpression: String);
begin
  inherited Create(Directory, detDirectories, DirectoryMask, RegularExpression, rfPaths);
end;


//======================================================================================================================
// class TFileAndDirectoryNameList =====================================================================================
//======================================================================================================================
constructor TFileAndDirectoryNameList.Create(Directory: String; DirectoryMask: String; RegularExpression: String);
begin
  inherited Create(Directory, detAll, DirectoryMask, RegularExpression, rfNames);
end;


//======================================================================================================================
// class TFileAndDirectoryPathList =====================================================================================
//======================================================================================================================
constructor TFileAndDirectoryPathList.Create(Directory: String; DirectoryMask: String; RegularExpression: String);
begin
  inherited Create(Directory, detAll, DirectoryMask, RegularExpression, rfPaths);
end;



end.
