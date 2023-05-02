let
    url_endpoint = "https://api.spotify.com/v1/playlists/37i9dQZF1DX1SBMQfWoBV6/tracks",
    token = token_acesso,

    #"obtendo dados" = Json.Document(
                Web.Contents(
                    url_endpoint,
                    [Headers=[
                        Authorization=token]]))[items],
    
    #"dados_tb" = Table.ExpandRecordColumn(
                        Table.RenameColumns(
                            Table.FromList(#"obtendo dados", Splitter.SplitByNothing(), null, null, ExtraValues.Error),
                                {{"Column1", "track"}}),
                                  "track", {"track"}, {"track"}),

    #"artists_tb" = Table.TransformColumnTypes
                              (Table.Distinct(
                                Table.ExpandRecordColumn(Table.ExpandListColumn(
                                        Table.ExpandRecordColumn(  
                                          #"dados_tb", "track", {"artists"}), "artists"),
                                            "artists", {"id", "name", "uri"})),
                                            {{"id", type text}, {"name", type text}, {"uri", type text}})
in
    artists_tb
