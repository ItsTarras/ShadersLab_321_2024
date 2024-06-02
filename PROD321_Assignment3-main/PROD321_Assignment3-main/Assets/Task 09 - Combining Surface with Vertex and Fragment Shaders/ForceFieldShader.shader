/* In Task 9, you will be adding code this combined
 * Surface, Vertex and Fragment shader to create a force
 * field effect, using a bunch of techniques we've learned
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task9/ForceFieldShader"
{
    // Unity Inspector properties
    Properties
    {
        /*******
        * TODO: Add the Texture for our mesh here (1/10)
        *******/
         _MainTexture ("Main Texture", 2D) = "white" {}


        // The amount to inflate the mesh along it's normals
        _InflationFactor ("Inflation Factor", Range(-.1, .5)) = 0.1

        /*******
         * TODO: Add the colour of the force field here (8/10)
         *******/
         _ForceColour ("Force Field Colour", Color) = (1, 1, 1, 1)

         _AlphaValue ("Alpha Value", Range(0, 1)) = 0.5
    }

    // Our Shader Program
    SubShader
    {

        // The first pass will be a surface shader which draws
        // the original model
        CGPROGRAM
        // Define a surface shader in the surf function using
        // the lambert lighting model
        #pragma surface surf Lambert

        // The input structure to our surface function
        struct Input
        {
            /*******
             * TODO: To ensure that texture tiling and offset values
             * get applied to the UV coordinates, we need to append
             * the texture name to the end of the uv coordinates, e.g
             * if our texture is called _MainTex, it should be uv_MainTex
             * or if our texture is called myTex, it should be uvmyTex (3/10)
             *******/
             float2 uv_MainTexture;
        };

        /*******
         * TODO: Add the sampler2D for our main texture (2/10)
         *******/
         sampler2D _MainTexture;
         
        // The definition of our Surface Output structure for reference
        /*
        struct SurfaceOutput
        {
            fixed3 Albedo;  // diffuse color
            fixed3 Normal;  // tangent space normal, if written
            fixed3 Emission;
            half Specular;  // specular power in 0..1 range
            fixed Gloss;    // specular intensity
            fixed Alpha;    // alpha for transparencies
        };
        */

        // The surface function, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutput called o
        void surf (Input IN, inout SurfaceOutput o)
        {
            /*******
             * TODO: Set surface output Albedo (Diffuse) colour by extracting
             * colour from texture using the tex2D function (4/10)
             *******/
             o.Albedo = tex2D(_MainTexture, IN.uv_MainTexture).rgb;
        }
        ENDCG

        // Our second pass is a vertex/fragment shader which renders to the depth buffer
        // using the expanded vertices (to avoid the self occluding overlaps)
        Pass
        {
            /*******
             * TODO: Turn on ZWriting (5/10)
             *******/
             ZWrite On

            /*******
             * TODO: Write nothing to the frame buffer using ColorMask (6/10)
             *******/
             ColorMask 0

            CGPROGRAM
            // Define a vertex shader in the vert function
            #pragma vertex vert
            // Define a fragment shader in the frag function
            #pragma fragment frag

            // Include UnityCG.cginc for helpful functions
            #include "UnityCG.cginc"

            // The input to our vertex shader in a struct
            // called appdata. It contains the vertex position
            // in model space in a variable called "vertex" and
            // the vertex normal in a variable called normal
            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            // The uniform variable for our inflation factor
            float _InflationFactor;

            
            // The vertex function, takes a variable of type appdata named
            // v and returns a float4 semantically tagged with SV_POSITION for
            // the homogeneous clip space vertex position
            float4 vert (appdata v) : SV_POSITION
            {
                // Shift the vertex position in the direction of the vertex normal
                // by the length of the inflation factor, transform this to 
                // homogeneous clip space, and then return this
                return UnityObjectToClipPos(v.vertex + v.normal * _InflationFactor);
            }

            // The fragment function, takes a variable of type float4 named
            // i and semantically tagged SV_POSITION (the homogeneous clip space
            // vertex position) and returns a colour semantically tagged with SV_Target
            fixed4 frag (float4 i : SV_POSITION) : SV_Target
            {
                // The "ColorMask 0" definition earlier means this fragment shader will
                // actually do nothing, but we still need to have it and return something
                // this colour will just be ignored
                return (0,0,0,0);
            }
            ENDCG
        }

        // Our third and final pass will render the force field itself based on the colour
        Pass
        {
            /*******
             * TODO: Define Blend Function (7/10)
             *******/
             Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            // Define a vertex shader in the vert function
            #pragma vertex vert
            // Define a fragment shader in the frag function
            #pragma fragment frag

            // Include UnityCG.cginc for helpful functions
            #include "UnityCG.cginc"

            // The input to our vertex shader in a struct
            // called appdata. It contains the vertex position
            // in model space in a variable called "vertex" and
            // the vertex normal in a variable called normal
            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            // The uniform variable for our inflation factor
            float _InflationFactor;

            /*******
             * TODO: Add the uniform variable for our force field colour (9/10)
             *******/
             fixed4 _ForceColour;

             float _AlphaValue;


            // The vertex function, takes a variable of type appdata named
            // v and returns a float4 semantically tagged with SV_POSITION for
            // the homogeneous clip space vertex position
            float4 vert (appdata v) : SV_POSITION
            {
                // Shift the vertex position in the direction of the vertex normal
                // by the length of the inflation factor, transform this to 
                // homogeneous clip space, and then return this
                return UnityObjectToClipPos(v.vertex + v.normal * _InflationFactor);
            }

            // The fragment function, takes a variable of type float4 named
            // i and semantically tagged SV_POSITION (the homogeneous clip space
            // vertex position) and returns a colour semantically tagged with SV_Target
            fixed4 frag (float4 i : SV_POSITION) : SV_Target
            {
                /*******
                 * TODO: Return the force field colour (10/10)
                 *******/

                 return (_ForceColour * _AlphaValue);
            }
            ENDCG
        }
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
