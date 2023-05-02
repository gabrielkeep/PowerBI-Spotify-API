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
    
    #"album_tb" = Table.TransformColumnTypes(Table.ExpandRecordColumn(
                                                Table.ExpandRecordColumn(#"dados_tb",
                                                                        "track", {"album"}, {"album"}),
                                                                            "album", {"id", "name", "release_date", "total_tracks", "album_type", "images"}), {{"id", type text}, {"name", type text},{"total_tracks",type number}, {"album_type", type text}, {"release_date", type date}}),

    #"album_tb_unicos" = Table.Distinct(#"album_tb", "id"),
    #"images Expandido" = Table.ExpandListColumn(album_tb_unicos, "images"),
    #"images Expandido1" = Table.ExpandRecordColumn(#"images Expandido", "images", {"url"}, {"images.url"}),

    #"album_tb2" = Table.Distinct(#"images Expandido1", "id") 
in
    #"album_tb2"