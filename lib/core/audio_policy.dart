/// Son des leçons suspendu jusqu'à la phase audio (jalon J6, décision de
/// l'utilisateur du 03/11/2026, cahier §13 et §16).
///
/// Tant que [AudioPolicy.enabled] est faux :
/// - aucun bouton d'écoute n'est affiché et aucun son de leçon n'est joué ;
/// - une question d'écoute devient une question de lecture : on montre la
///   lecture écrite (translittération) et on choisit l'écriture arabe ;
///   « lire » propose des lectures écrites au lieu de sons ;
/// - « répéter à voix haute » et les épreuves d'écoute et de prononciation
///   des examens sont masquées.
///
/// Les données gardent un emplacement audio pour chaque lettre, syllabe, mot
/// et phrase : remettre [AudioPolicy.enabled] à vrai suffira à la phase
/// audio. Les tests de la lecture des sons le passent à vrai.
library;

abstract final class AudioPolicy {
  static bool enabled = false;
}
