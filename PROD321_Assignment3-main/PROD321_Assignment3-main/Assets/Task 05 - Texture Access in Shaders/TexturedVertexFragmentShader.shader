/* In Task 5, you will be adding code this vertex fragment
 * shader to support Textures
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task5/TexturedVertexFragmentShader"
{
    // Unity Inspector properties
    Properties
    {
        /*******
         * TODO: Add Texture property
         *******/
         _MainTex ("Texture", 2D) = "white" {}

    }

    // Our Shader Program
    SubShader
    {
        Pass {
            CGPROGRAM

            // Define a vertex shader in the function vert
            // and a fragment shader in the function frag
            #pragma vertex vert
            #pragma fragment frag

            // Include UnityCG.cginc for helpful functions
            #include "UnityCG.cginc"

            // The input to our vertex shader in a struct
            // called appdata. It contains the vertex position
            // in model space in a variable called "vertex" and
            // the vertex uv channel 0 coordinates in a variable
            // called uv
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            // The output of our vertex shader and the input
            // to our fragment shader in a struct called v2f.
            // It contains the vertex/fragment position in
            // homogeneous clip space in a variable called "vertex"
            // and the uv channel 0 coordinates in a variable called
            // uv
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            /*******
             * TODO: Add the uniform variable for our texture property
             * Also add a float4 to contain the tiling and offset values
             * for our property (the name of which needs to be our texture
             * name + "_ST" - e.g. if our texture is called _MainTex this variable
             * needs to be called _MainTex_ST
             *******/
             sampler2D _MainTex;
             float4 _MainTex_ST;


            // The vertex function, takes a variable of type appdata named v
            // and returns a variable of type v2f
            v2f vert (appdata v)
            {
                // Create our output variable
                v2f o;

                // Transform our vertex from model space to homogenous clip space
                o.vertex = UnityObjectToClipPos(v.vertex);

                /*******
                 * TODO: Transform our uv coordinates based on the tiling and
                 * offset properties of our texture, using the TRANSFORM_TEX function
                 *******/
                 o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                // Return our output variable
                return o;
            }

            // The fragment function, takes a variable of type v2f named i
            // and returns a colour semantically tagged with SV_Target
            fixed4 frag (v2f i) : SV_Target
            {
                // Create our output colour variable
                fixed4 col = (0,0,0,0);

                /*******
                 * TODO: Set the output colour variable by extracting
                 * colour from texture using the tex2D function
                 *******/
                 col = tex2D(_MainTex, i.uv);
                // Return the colour
                return col;
            }
            ENDCG
        }
    }
}
