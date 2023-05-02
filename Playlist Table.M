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

    #"playlist_tb" = 
                        Table.Distinct
                            (Table.ExpandRecordColumn
                                (Table.ExpandListColumn
                                    (Table.ExpandRecordColumn
                                        (Table.ExpandRecordColumn(
                                            dados_tb, "track", {"album", "artists", "disc_number", "duration_ms", "explicit", "name", "popularity", "uri"}), "album", {"id"}, {"album_id"}), "artists"), "artists", {"id"}, {"artists_id"}),{"disc_number", "duration_ms", "explicit", "name", "popularity", "uri", "album_id"}),
    #"alterando_formato" = 
            Table.TransformColumnTypes(playlist_tb,
                    {{"album_id", type text}, {"artists_id", type text}, {"disc_number", Int64.Type}, {"duration_ms", Int64.Type}, {"explicit", type logical}, {"name", type text}, {"popularity", Int64.Type}, {"uri", type text}}),
    #"Personalização Adicionada" = Table.AddColumn(alterando_formato, "duration_m", each [duration_ms]/60000),
    Arredondado = Table.TransformColumns(#"Personalização Adicionada",{{"duration_m", each Number.Round(_, 1), type number}}),
    #"Colunas Reordenadas" = Table.ReorderColumns(Arredondado,{"album_id", "artists_id", "disc_number", "duration_ms", "duration_m", "explicit", "name", "popularity", "uri"}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Reordenadas",{{"duration_m", Int64.Type}})
in
    #"Tipo Alterado"
