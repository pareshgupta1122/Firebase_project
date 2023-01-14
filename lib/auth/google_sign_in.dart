
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
 signInWithGoogle() async{
  // begin interative signin process
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //obtain auth details from request

  final GoogleSignInAuthentication gAuth= await gUser!.authentication;

  //create a new credential for a user

  final credential =GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );
  
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

}

