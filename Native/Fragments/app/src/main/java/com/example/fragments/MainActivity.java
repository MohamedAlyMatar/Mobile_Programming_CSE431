package com.example.fragments;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {
    Button btn01;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d("debug101", "MainActivity_1 onCreate");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btn01 = findViewById(R.id.btn01);

        btn01.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                FragmentManager fragM = getSupportFragmentManager();
                FragmentTransaction trans = fragM.beginTransaction();
                FragmentB fragB = new FragmentB();
                trans.replace(R.id.fragmentContainerView, fragB);
                trans.addToBackStack(null);
                trans.commit();

            }
        });

//        btn01.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                FragmentManager fragmentManager = getSupportFragmentManager();
//                FragmentB fragmentB = (FragmentB) fragmentManager.findFragmentByTag("FragmentB");
//
//                if (fragmentB == null) {
//                    // FragmentB is not in the back stack, replace it with FragmentB
//                    FragmentTransaction transaction = fragmentManager.beginTransaction();
//                    transaction.replace(R.id.fragmentContainerView, new FragmentB(), "FragmentB");
//                    transaction.addToBackStack(null); // Add the transaction to the back stack
//                    transaction.commit();
//                } else {
//                    // FragmentB is currently displayed, pop the back stack to return to FragmentA
//                    fragmentManager.popBackStack("FragmentB", 0);
//                }
//            }
//        });
    }

    @Override
    protected void onStart(){
        super.onStart();
        Log.d("debug101", "MainActivity_1 onStart");
    }

    @Override
    protected void onResume(){
        super.onResume();
        Log.d("debug101", "MainActivity_1 onResume");
    }

    @Override
    protected void onPause(){
        super.onPause();
        Log.d("debug101", "MainActivity_1 onPause");
    }

    @Override
    protected void onStop(){
        super.onStop();
        Log.d("debug101", "MainActivity_1 onStop");
    }

    @Override
    protected void onRestart(){
        super.onRestart();
        Log.d("debug101", "MainActivity_1 onRestart");
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        Log.d("debug101", "MainActivity_1 onDestroy");
    }

    @Override
    protected void onRestoreInstanceState(@NonNull Bundle savedInstanceState){
        super.onRestoreInstanceState(savedInstanceState);
        Log.d("debug101", "MainActivity_1 onRestoreInstanceState");
    }

    @Override
    protected void onSaveInstanceState(@NonNull Bundle outState){
        super.onSaveInstanceState(outState);
        Log.d("debug101", "MainActivity_1 onSaveInstanceState");
    }
}