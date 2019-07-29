module Text : sig

  type t

  val of_string : string -> t

  val length : t -> int

end = struct

  type t = int array

  let of_string str =
    Array.init
      (String.length str)
      (fun n -> int_of_char @@ String.get str n)

  let length text =
    match Array.length text with
      | 0 -> 0
      | bytes ->
        let count = ref 0 in
        let pos = ref 0 in
        while !pos < bytes do
          count := !count + 1;
          let ascii = text.(!pos) in
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
end

let () = print_endline @@ string_of_int @@ Text.length @@ Text.of_string "あいうえお"  (* => 5 *)
