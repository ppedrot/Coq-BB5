(* TNF Root 1RB---_1LC---_------_------_------ *)

From CoqBB5 Require Import BB52TheoremPrelim.

Definition q_1_manual := (SearchQueue_upds root4_q decider_all 0).

Definition root4_nontrivial_6 := nth 9 (fst q_1_manual) root.

Definition q_0 := SearchQueue_init root4_nontrivial_6.

Definition q_200_def := Nat.iter 200 q_suc q_0.
Definition q_200 : SearchQueue := Eval native_compute in q_200_def.

Lemma q_200_spec: q_200 = Nat.iter 200 q_suc q_0.
Proof.
  assert (q_200 = q_200_def) as H  by (native_cast_no_check (eq_refl q_200)).
  rewrite H. unfold q_200_def. reflexivity.
Qed.

Lemma q_200_empty:
  q_200 = (nil,nil).
Proof.
  reflexivity.
Qed.

Lemma q_200_WF:
  SearchQueue_WF (N.to_nat BB5_minus_one) q_200 root4_nontrivial_6.
Proof.
  rewrite q_200_spec.
  apply q_200_WF_gen.
  red. repeat split.
  1: cbn; cg.
  unfold UnusedState_ptr.
  left.
  intros.
  unfold UnusedState. cbn. unfold St_le. cbn.
  destruct s0; cbn; split; try lia.
  all: repeat split; try congruence.
  all: try intros ? [].
  all: try (intros []; try congruence).
  all: try destruct s0; cbn; try tauto.
  all: try congruence.
  - destruct H0. specialize (H0 Σ0). cbn in *. 
    congruence.
  - cbv in H. specialize (H St1 Σ0). cbn in *. congruence.
Qed.

Lemma root4_nontrivial_6_HTUB:
  TNF_Node_HTUB (N.to_nat BB5_minus_one) root4_nontrivial_6.
Proof.
  epose proof q_200_WF.
  unfold SearchQueue_WF in H.
  rewrite q_200_empty in H.
  apply H.
  cbn.
  intros.
  contradiction.
Qed.
