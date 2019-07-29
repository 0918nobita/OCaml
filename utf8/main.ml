open Base

module UChar : sig

  type t

  val of_char : char -> t

  val of_bytes : int list -> t

  val string_of : t -> string

end = struct

  type t = int array

  let of_char c = [| Char.to_int c |]

  let of_bytes = Array.of_list

  let string_of uchar =
    String.init (Array.length uchar) (fun n -> Char.unsafe_of_int @@ uchar.(n))
end

module Text : sig

  type t

  val length : t -> int

  val get : t -> int -> UChar.t

  val of_string : string -> t

end = struct

  type t = UChar.t array

  let length = Array.length

  let get = Array.get

  let of_string str =
    match String.length str with
      | 0 -> [| |]
      | bytes ->
          let uchars = ref [] in
          let pos = ref 0 in
          while !pos < bytes do
            let ascii = Char.to_int @@ String.get str !pos in
            if ascii land 0x80 = 0
              then
                begin
                  pos := !pos + 1;
                  uchars := UChar.of_bytes [ascii] :: !uchars;
                end
              else
                begin
                  let bytes = ref [] in
                  let tmp = ref (ascii land 0xFC) in
                  while not (!tmp land 0x80 = 0) do
                    bytes := (Char.to_int @@ String.get str !pos) :: !bytes;
                    pos := !pos + 1;
                    tmp := !tmp lsl 1;
                  done;
                  uchars := UChar.of_bytes (List.rev !bytes) :: !uchars
                end
          done;
          Array.of_list @@ List.rev !uchars

end
