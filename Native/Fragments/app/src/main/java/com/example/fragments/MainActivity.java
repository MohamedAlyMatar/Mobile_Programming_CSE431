package com.example.fragments;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {
    Button btn01;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
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
                trans.commit();
                trans.addToBackStack(null);
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
}