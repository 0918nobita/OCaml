open Ast_mapper
open Ast_helper
open Asttypes
open Parsetree
open Longident

let rec expr_mapper mapper = function
  | { pexp_desc = Pexp_extension ({ txt = "addone"; loc }, pstr); pexp_loc = _; pexp_attributes = _ } ->
      (match pstr with
        | PStr [{ pstr_desc = Pstr_eval (expression, _); pstr_loc = _ }] ->
            Exp.apply
              (Exp.ident { txt = Lident "+"; loc = !(default_loc) })
              [(Nolabel, expr_mapper mapper expression); (Nolabel, Exp.constant (Pconst_integer ("1", None)))]
        | _ -> raise (Location.Error (Location.error ~loc "SyntaxError")))
  | x -> default_mapper.expr mapper x

let addone_mapper _ = { default_mapper with expr = expr_mapper }

let () = register "addone" addone_mapper
