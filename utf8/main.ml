let strlen text =
  match String.length text with
    | 0 -> 0
    | bytes ->
      let count = ref 0 in
      let pos = ref 0 in
      while !pos < bytes do
        count := !count + 1;
        let ascii = int_of_char @@ String.get text !pos in
        if ascii land 0x80 = 0
          then pos := !pos + 1
          else
            let tmp = ref (ascii land 0xFC) in
            while !tmp land 0x80 != 0 do
              pos := !pos + 1;
              tmp := !tmp lsl 1
            done
      done;
      !count

let () = print_endline @@ string_of_int @@ strlen "あいうえお"  (* => 5 *)
