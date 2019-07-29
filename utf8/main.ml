module UChar : sig

  type t

  val of_char : char -> t

end = struct

  type t = int array

  let of_char c = [| Char.code c |]

end

(*
module Text : sig

  type t

  val of_string : string -> t

  val length : t -> int

  val get : t -> int -> t option

  val get_exn : t -> int -> t

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

  exception Out_of_loop of int array

  let unwrap = function
    | Some v -> v
    | _ -> raise @@ Invalid_argument "Unwrap failure"

  let get text i =
    match Array.length text with
      | 0 -> None
      | bytes ->
        let index = ref (-1) in
        let pos = ref 0 in
        try
          while !pos < bytes do
            index := !index + 1;
            let ascii = text.(!pos) in
            if ascii land 0x80 = 0
              then
                begin
                  pos := !pos + 1;
                  if i = !index then raise @@ Out_of_loop [| ascii |]
                end
              else
                begin
                  let tmp = ref (ascii land 0xFC) in
                  let array = ref [| |] in
                  while !tmp land 0x80 != 0 do
                    pos := !pos + 1;
                    array := Array.append !array [| !tmp |];
                    tmp := !tmp lsl 1
                  done;
                  if i = !index then (Array.iter (fun i -> print_endline @@ string_of_int i) !array; raise @@ Out_of_loop !array)
                end
          done;
          None
        with
          | Out_of_loop text -> Some text

  let get_exn text i = unwrap @@ get text i

  let sub text start len =
    let text_len = length text in
    if text_len >= start + len
      then Some ()
      else None

end

let () = print_endline @@ string_of_int @@ Text.length @@ Text.of_string "あいうえお"  (* => 5 *)
*)
